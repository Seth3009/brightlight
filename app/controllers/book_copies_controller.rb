class BookCopiesController < ApplicationController
  before_action :set_book_copy, only: [:edit, :destroy, :checks, :update_book_copy]
  before_action :sortable_columns, only: [:index]

  # GET /book_copies
  # GET /book_copies.json
  def index
    authorize! :read, BookCopy
    if params[:book_edition_id].present?
      @book_edition = BookEdition.find(params[:book_edition_id])      
      @by_condition = @book_edition.summary_by_conditions
      @total_by_condition = @by_condition.reduce(0) {|r,x| r + (x[:total] || 0)}
      @by_status = @book_edition.summary_by_status
      @total_by_status = @by_status.reduce(0) {|r,x| r + (x[:total] || 0)}
      @condition = BookCondition.where(id:params[:condition]).take if params[:condition].present? and params[:condition] != 'all' and params[:condition] != 'na'
      @status = Status.where(id:params[:status]).take if params[:status].present? and params[:status] != 'all' and params[:status] != 'na'
      @book_copies = @book_edition.book_copies
        .with_condition(params[:condition]).with_status(params[:status]).with_active_loans(AcademicYear.current_id)
    else
      @book_copies = BookCopy.all.order(:copy_no)
    end
    @book_copies = @book_copies.order("#{sort_column} #{sort_direction}")
  end

  # GET /book_copies/1
  # GET /book_copies/1.json
  def show
    authorize! :read, BookCopy
    if params[:id].strip[0..2] == 'INV'
      @book_copy = BookCopy.unscoped.find_by_barcode(params[:id])
    else
      @book_copy = BookCopy.unscoped.find(params[:id])
    end
    respond_to do |format|
      format.html do
        Barcode.new(@book_copy.barcode).write_image if @book_copy.present?
      end
      format.json do
        if params[:status]
          @book_copy = BookCopy.where(status_id:params[:status]).where('UPPER(barcode) = ?', params[:id].upcase).includes(:book_edition => :book_title).take
        else
          @book_copy = BookCopy.where('UPPER(barcode) = ?', params[:id].upcase).includes(:book_edition => :book_title).take
        end
        if @book_copy.present?
          @book_edition = @book_copy.book_edition
          @book_title = @book_edition.try(:book_title)
          @student = Student.find params[:st] if params[:st].present?
          @employee = Employee.find params[:empl] if params[:empl].present?
          if params[:year] == 'any'
            @loan = @book_copy.book_loans.order('academic_year_id DESC, updated_at DESC').take
          else
            @year = params[:year].present? ? AcademicYear.find(params[:year]) : AcademicYear.current
            @loan = @book_copy.book_loans.where(academic_year_id:@year.id).order('updated_at DESC').take
          end
        else
          render json: {errors:"Invalid barcode"}, status: :unprocessable_entity
        end
      end
      format.js do
        set_book_copy 
        @copy_loans = BookLoan.where(book_copy_id:params[:id])
                          .includes([:academic_year, :student, :employee])
                          .order('academic_year_id DESC, out_date DESC')
      end 
    end
  end

  # GET /book_copies/1/check_barcode.json
  def check_barcode
    authorize! :read, BookCopy
    set_book_copy
    respond_to do |format|
      format.json do
        if @book_copy.present?
          render json: { barcode: @book_copy.barcode }
        else
          render json: {}, status: :unprocessable_entity
        end
      end
    end
  end

  # GET /book_copies/new
  def new
    authorize! :manage, BookCopy
    @book_edition = BookEdition.find(params[:book_edition_id])
    @book_copy = @book_edition.book_copies.new
    @book_labels_for_menu = GradeSection.all.includes(:book_labels).order(:grade_level_id, :id)
  end

  # GET /book_copies/1/edit
  def edit
    authorize! :update, @book_copy
  end

  # GET /book_copies/1/edit
  def edit_labels
    authorize! :update, BookCopy
    @book_edition = BookEdition.find(params[:book_edition_id])
    @book_copies = @book_edition.book_copies.order(:book_label_id)
    @grade_level_ids = GradeLevel.all.collect(&:id)
    @grade_sections = GradeSection.all.order(:grade_level_id, :id)
    @book_labels_for_menu = GradeSection.all.includes(:book_labels).order(:id)

    if params[:s].present?
      @grade_section = @grade_sections.where(id:params[:s]).first
    end
  end

  # POST /book_copies
  # POST /book_copies.json
  def create
    authorize! :manage, BookCopy
    @book_edition = BookEdition.new(book_edition_params)

    respond_to do |format|
      if @book_edition.save
        format.html { redirect_to book_edition_book_copies_path(@book_edition), notice: 'Book copy was successfully created.' }
        format.json { render :show, status: :created, location: @book_edition }
      else
        format.html { render :new }
        format.json { render json: @book_edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_copies/1
  # PATCH/PUT /book_copies/1.json
  def update
    authorize! :update, BookCopy
    @book_copy = BookCopy.unscoped.find(params[:id])
    respond_to do |format|
      if @book_copy.update(book_copy_params)        
        format.html { redirect_to @book_copy, notice: 'Book copy was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_edition }
        format.js { render :js => "window.location.href='"+book_edition_book_copies_path(@book_copy.book_edition_id)+"'" }
      else
        format.html { render :edit }
        format.json { render json: @book_copy.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # POST /book_copies/update_multiple
  # POST /book_copies/update_multiple
  def update_multiple
    authorize! :update, BookCopy
    list = params[:book_copy].reject {|k,v| k.downcase == 'all'}
    @book_copies = BookCopy.where id: list.keys
    if params[:condition]
      @book_copies.each do |copy|
        copy.create_condition(params[:condition], AcademicYear.current_id, current_user.id)
      end
    end
    if params[:status]
      @book_copies.update_all status_id:params[:status]
    end
    book_edition = @book_copies.last.book_edition      
    redirect_to book_edition_book_copies_path(book_edition)
  end

  # DELETE /book_copies/1
  # DELETE /book_copies/1.json
  def destroy
    authorize! :destroy, @book_copy
    book_edition = @book_copy.book_edition
    respond_to do |format|
      if @book_copy.destroy
        format.html { redirect_to book_edition_book_copies_path(book_edition), notice: 'Book copy was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to book_edition_book_copies_path(book_edition), alert: @book_copy.errors.full_messages.join('. ') }
        format.json { render json: @book_copy.errors, status: :unprocessable_entity }
      end 
    end
  end

  # POST /book_copies/dispose
  def dispose
    authorize! :destroy, BookCopy
    if params[:book_copy] || params[:s_book_copy]
      @book_copies = BookCopy.where(id: (params[:book_copy].present? ? params[:book_copy].map{|id, on| id} : params[:s_book_copy].map{|id, on| id}))
      book_edition = @book_copies.last.book_edition
      if @book_copies.map{|x| x.borrowed_in_year(AcademicYear.current_id)}.reject{|x| !x}.empty?
        @book_copies.update_all(disposed: true, disposed_at: Date.today)
        if params[:book_copy]
          redirect_to book_edition_book_copies_path(book_edition), notice: 'Selected book copies were successfully deleted.'
        else
          redirect_to book_copies_dispose_books_path(), notice: 'Selected book copies were successfully deleted.'
        end
      else
        redirect_to book_edition_book_copies_path(book_edition), alert: 'Error: Some selected book copies are still borrowed.'
      end
    else
      redirect_to book_edition_book_copies_path(book_edition)
    end
  end

  # POST /book_copies/1/undispose
  def undispose
    authorize! :manage, BookCopy
    @book_copy = BookCopy.unscoped.find params[:id]
    @book_copy.disposed = false
    @book_copy.disposed_at = nil
    if @book_copy.save
      if params[:undo] == 'yes'
        redirect_to :back, notice: "Successfully changed disposed status of book #{@book_copy.barcode}"
      else
        redirect_to @book_copy, notice: "Successfully changed disposed status of book #{@book_copy.barcode}"
      end
    else
      redirect_to @book_copy, alert: "Failed to change disposed status of book #{@book_copy.barcode}"
    end  
  end

  # GET /book_copies/1/conditions
  def conditions
    authorize! :read, BookCopy
    if params[:all].present?
      @copy_conditions = CopyCondition.where(book_copy_id:params[:id]).order('academic_year_id DESC, updated_at DESC')
    else
      @copy_conditions = CopyCondition.where(book_copy_id:params[:id]).where.not(deleted_flag:true).order('academic_year_id DESC, updated_at DESC')
    end
    @copy_conditions = @copy_conditions.includes([:academic_year, :book_condition, :user])
    @book_copy = BookCopy.includes([:book_edition]).find(params[:id])
    @book_edition = @book_copy.book_edition
    @last_condition = @copy_conditions.first
  end

  # GET /book_copies/1/loans
  def loans
    authorize! :read, BookCopy
    @copy_loans = BookLoan.where(book_copy_id:params[:id])
                          .includes([:academic_year, :student, :employee])
                          .order('academic_year_id DESC, out_date DESC')
    @book_copy = BookCopy.where(id:params[:id]).includes([:book_edition]).take
    @book_edition = @book_copy.book_edition
    @last_loan = @copy_loans.first
  end

  # GET /book_copies/1/checks
  def checks
    authorize! :read, BookCopy
    @book_edition = @book_copy.book_edition
    @checks = @book_copy.loan_checks.details
              
  end

  # GET /book_copies/disposed_index
  def disposed_index
    authorize! :manage, BookCopy
    # Output of the following statement is a hash in this format
    #  {[1303, "Children's Picture Atlas", "Ruth Brocklehurst, Linda Edwards"]=>2, [1582, "Caps for sale", "Esphyr Slobodkina"]=>4}
    @edition_list = BookCopy.unscoped.where(disposed: true)
                      .group(:book_edition_id, 'book_editions.title', 'book_editions.authors')
                      .joins(:book_edition)
                      .count
  end

  # GET /book_copies/dispose_books
  def dispose_books
    @start_date = params[:dts].present? ?  params[:dts] : Date.today
    @end_date = params[:dte].present? ?  params[:dte] : Date.today
    @book_copies = BookCopy.unscoped.where(disposed: true, disposed_at: (@start_date)..(@end_date))
    respond_to do |format|
      format.html 
      format.pdf do
        @book_copies = @book_copies.order('disposed_at, barcode')
        render pdf:         "Teacher's Books - Periode #{@start_date} to #{@end_date}",
               disposition: 'inline',
               template:    'book_copies/dispose_books.pdf.slim',
               layout:      'pdf.html',
               header:      { left: "Disposed Books", right: '[page] of [topage]' },
               show_as_html: params.key?('debug')
      end
    end
  end

  # GET /book_copies/dispose_books/new_list
  def new_book_dispose
    authorize! :update, @book_copy
    if params[:id].present?
      @book_copy = BookCopy.unscoped.find(params[:id])
      if @book_copy.update(disposed:true, disposed_at:Date.today) 
        flash[:notice] = 'Book copy was successfully updated.'
      end
    end
  end

  # PATCH/PUT /book_copies/dispose_books/new_list/1.json
  def update_book_copy
    authorize! :update, BookCopy
    # @book_copy = BookCopy.unscoped.find(params[:id])
    respond_to do |format|
      if @book_copy.update(disposed:true, disposed_at:Date.today, disposed_notes:params[:notes])        
        format.json { render :show, status: :ok, location: @book_copy }
      else
        format.json {flash[:alert] = 'Book copy was not successfully updated.'}
      end
    end
  end

  # GET /book_editions/1/book_copies/disposed
  def disposed
    authorize! :manage, BookCopy
    if params[:book_edition_id].present?
      @book_edition = BookEdition.find(params[:book_edition_id])      
      @book_copies = BookCopy.unscoped.where(disposed: true).where(book_edition: @book_edition)
        .with_condition(params[:condition]).with_status(params[:status])
    else
      @book_copies = BookCopy.unscoped.where(disposed: true).order(:copy_no)
    end
    @book_copies = @book_copies.order("#{sort_column} #{sort_direction}")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_copy
      if params[:id].strip[0..2] == 'INV'
        @book_copy = BookCopy.find_by_barcode(params[:id])
      elsif params[:disposed]
        @book_copy = BookCopy.unscoped.find(params[:id])
      else 
        @book_copy = BookCopy.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_copy_params
      params.require(:book_copy).permit(:book_edition_id, :book_condition_id, :book_label_id, :status_id, :barcode, :copy_no, :notes,
                                        {:book_copies => [:barcode, :grade_section_id, :no]})
    end

    def sortable_columns 
      [:book_label_id, :barcode, :condition_id, :status_id]
    end 
end
