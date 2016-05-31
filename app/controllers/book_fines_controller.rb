class BookFinesController < ApplicationController
  before_action :set_book_fine, only: [:show, :edit, :update, :destroy]

  autocomplete :student, :name

  # GET /book_fines
  # GET /book_fines.json
  def index
    authorize! :manage, BookFine
    if params[:year].present?
      @academic_year = AcademicYear.find params[:year]
    else
      @academic_year = AcademicYear.current
    end

    # TODO: Optimize with eager loading
    #   @students = Student.eager_load([:book_fines,:grade_sections_students]).where("book_fines.academic_year_id = ? and grade_sections_students.academic_year_id = ?", @academic_year.id, @academic_year.id)

    @book_fines = BookFine.where(academic_year:@academic_year).order(:student_id)
    @students = Student.joins(:book_fines).where(book_fines: {academic_year: @academic_year}).uniq.eager_load(:grade_sections_students).where('grade_sections_students.academic_year_id = ?', @academic_year.id).eager_load(:grade_sections)
    @grade_sections = GradeSection.joins(:grade_sections_students)
                      .where('grade_sections_students.student_id in (SELECT DISTINCT "students".id FROM "students" INNER JOIN "book_fines" ON "book_fines"."student_id" = "students"."id" WHERE "book_fines"."academic_year_id" = ?) and grade_sections_students.academic_year_id = ?', @academic_year.id, @academic_year.id)
                      .sort.uniq
    if params[:st].present?
      @student = Student.where(id:params[:st]).take
      @book_fines = @book_fines.where(student_id:params[:st])
    end
    if params[:s].present?
      @grade_section = GradeSection.where(id:params[:s]).take
      @book_fines = @book_fines.where("student_id in
          (SELECT students.id FROM students INNER JOIN grade_sections_students
          ON grade_sections_students.student_id = students.id
          WHERE grade_sections_students.grade_section_id = ?
          AND grade_sections_students.academic_year_id = ?)", @grade_section.id, @academic_year.id)
    end
    @book_fines = @book_fines.includes([:student,:old_condition,:new_condition]).includes(:book_copy => :book_edition)
    @dollar_rate = Currency.dollar_rate
  end

  # GET /book_fines/1
  # GET /book_fines/1.json
  def show
    authorize! :manage, BookFine
    @book_copy = @book_fine.book_copy
    @book_edition = @book_copy.try(:book_edition)
    @student = @book_fine.student
  end

  # GET /book_fines/new
  def new
    authorize! :manage, BookFine
    @book_fine = BookFine.new
  end

  # GET /book_fines/1/edit
  def edit
    authorize! :manage, BookFine
    @book_copy = @book_fine.book_copy
    @book_edition = @book_copy.try(:book_edition)
    @book_title = @book_edition.try(:title)
    @currency = @book_edition.try(:currency)
    @price = @book_edition.try(:price)
    @barcode = @book_copy.try(:barcode)
  end

  # POST /book_fines
  # POST /book_fines.json
  def create
    authorize! :manage, BookFine
    @book_fine = BookFine.new(book_fine_params)

    respond_to do |format|
      if @book_fine.save
        format.html { redirect_to @book_fine, notice: 'Book fine was successfully created.' }
        format.json { render :show, status: :created, location: @book_fine }
      else
        format.html { render :new }
        format.json { render json: @book_fine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_fines/1
  # PATCH/PUT /book_fines/1.json
  def update
    authorize! :manage, BookFine
    respond_to do |format|
      if @book_fine.update(book_fine_params)
        format.html { redirect_to @book_fine, notice: 'Book fine was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_fine }
      else
        format.html { render :edit }
        format.json { render json: @book_fine.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /book_fines/current
  def current
    authorize! :manage, BookFine
  end

  # GET /book_fines/calculate
  def calculate
    authorize! :manage, BookFine
    BookFine.collect_current
    redirect_to book_fines_path
  end

  # GET /book_fines/notification?st=1&year=1
  def notification
    authorize! :manage, BookFine
    @academic_year = AcademicYear.find params[:year]

    # Use the specified template or the default one if none given
    if params[:template].present?
      @template = Template.find params[:template]
    else
      @template = Template.where(target:'book_fine').take
    end
    if params[:st].present?
      @student = Student.where(id:params[:st]).take
      @book_fines = BookFine.where(academic_year:@academic_year).where(student_id:params[:st])
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf:         "notification-#{@student.student_no}.pdf",
               disposition: 'inline',
               template:    'book_fines/notification.pdf.slim',
               layout:      'pdf.html',
               show_as_html: params.key?('debug')
      end
    end
  end

  # GET /book_fines/payment?st=1
  def payment
    authorize! :manage, BookFine
    @academic_year = AcademicYear.current
    @student = Student.where(id:params[:st]).includes(:grade_sections_students).take
    @book_fines = BookFine.where(academic_year:@academic_year).where(student_id:params[:st]).includes([:book_copy, :old_condition, :new_condition])
    @currency = "Rp"
    @dollar = Currency.dollar_rate
    @total_idr_amount = @book_fines.reduce(BigDecimal.new("0")){|sum,f| sum + ( f.currency=="USD" ? f.fine * @dollar : f.fine )}

    # The tag is to identify the invoice with the book fines
    @tag = Digest::MD5.hexdigest "#{@academic_year.id}-#{@student.id}-#{@total_idr_amount}"

    # Take the last created invoice with the tag, or create one if none found
    @invoice = Invoice.where(tag: @tag).order('created_at DESC').take
    unless @invoice.present?
      @invoice = Invoice.create(
                   student: @student,
                   bill_to: @student.name,
                   grade_section: @student.current_grade_section.name,
                   roster_no: @student.current_roster_no,
                   total_amount: @total_idr_amount.to_f.round(-2),
                   currency: @currency,
                   statuses: 'Created',
                   paid: false,
                   tag: @tag,
                   user: current_user
                 )
      @book_fines.each do |f|
        idr_amount = f.currency=="USD" ? f.fine * @dollar : f.fine
        @invoice.line_items.create(description: f.book_copy.try(:book_edition).try(:title),
                                    price: f.currency=="USD" ? f.fine * @dollar : f.fine,
                                    ext1: f.old_condition.code,
                                    ext2: f.new_condition.code,
                                    ext3: "#{f.percentage * 100}%"
                                  )
      end
    end
    @print_date = Date.today.strftime("%d-%m-%Y")

    # Use the specified template or the default one if none given
    if params[:template].present?
      @template = Template.find params[:template]
    else
      @template = Template.where(target:'book_fine_receipt').take
    end
    @template.placeholders = {
      receipt_date: @print_date,
      receipt_no: @invoice.id,
      student_name: @student.name,
      student_grade: @student.current_grade_section.name,
      student_no: @student.current_roster_no,
      receipt_amount: helpers.number_to_currency(@total_idr_amount.to_f.round(-2), {unit:'Rp', precision:0}),
      receipt_amount_in_words: @total_idr_amount.to_f.round(-2).to_words.split.map(&:capitalize).join(' '),
      academic_year: @academic_year.name
    }
  end

  # DELETE /book_fines/1
  # DELETE /book_fines/1.json
  def destroy
    authorize! :manage, BookFine
    @book_fine.destroy
    respond_to do |format|
      format.html { redirect_to book_fines_url, notice: 'Book fine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_fine
      @book_fine = BookFine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_fine_params
      params.require(:book_fine).permit(:book_copy_id, :old_condition_id, :new_condition_id, :fine, :currency, :academic_year_id, :student_id, :status)
    end

    def helpers
      ActionController::Base.helpers
    end
end
