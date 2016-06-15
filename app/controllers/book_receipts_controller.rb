class BookReceiptsController < ApplicationController
  before_action :set_book_receipt, only: [:show, :edit, :update, :destroy]

  # GET /book_receipts
  # GET /book_receipts.json
  def index
    @book_receipts = BookReceipt.all
    authorize! :manage, StudentBook
    if params[:gs].present?
      @grade_section = GradeSection.find params[:gs]
      @grade_level = @grade_section.grade_level
      @book_labels = BookLabel.where(grade_section:@grade_section)
      @book_copies = BookCopy.standard_books(@grade_level.id,@grade_section.id,AcademicYear.current.id)
                    .includes([:book_edition])
    end
    if params[:l].present?
      @book_labels = @book_labels.where(id:params[:l])
      @grade_level ||= GradeLevel.find(@book_labels.first.grade_level_id)
      @grade_level_name = @grade_level.name
      @grade_section_name = @book_labels.first.section_name
    end

    # Use the specified template or the default one if none given
    if params[:template].present?
      @template = Template.find params[:template]
    else
      @template = Template.where(target:'student_book_receipt').where(active:'true').take
    end
    if @template
      @template.placeholders = {
        grade_section: @grade_section_name,
        academic_year: AcademicYear.current.name,
        student_name: ''
      }
    end

    respond_to do |format|
      format.html do
        @grade_level_ids = GradeLevel.all.collect(&:id)
        @grade_sections = GradeSection.all
        @grade_sections_ids = @grade_sections.collect(&:id)
      end
      format.pdf do
        render pdf:         'form.pdf',
               disposition: 'inline',
               template:    'student_books/receipt_form.pdf.slim',
               layout:      'pdf.html',
               show_as_html: params.key?('debug')
      end
    end
  end

  # GET /book_receipts/1
  # GET /book_receipts/1.json
  def show
  end

  # GET /book_receipts/new
  def new
    @book_receipt = BookReceipt.new
  end

  # GET /book_receipts/1/edit
  def edit
  end

  # POST /book_receipts
  # POST /book_receipts.json
  def create
    @book_receipt = BookReceipt.new(book_receipt_params)

    respond_to do |format|
      if @book_receipt.save
        format.html { redirect_to @book_receipt, notice: 'Book receipt was successfully created.' }
        format.json { render :show, status: :created, location: @book_receipt }
      else
        format.html { render :new }
        format.json { render json: @book_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_receipts/1
  # PATCH/PUT /book_receipts/1.json
  def update
    respond_to do |format|
      if @book_receipt.update(book_receipt_params)
        format.html { redirect_to @book_receipt, notice: 'Book receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_receipt }
      else
        format.html { render :edit }
        format.json { render json: @book_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_receipts/1
  # DELETE /book_receipts/1.json
  def destroy
    @book_receipt.destroy
    respond_to do |format|
      format.html { redirect_to book_receipts_url, notice: 'Book receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /book_receipts/initialize.js
  def initialize
    authorize! :manage, BookReceipt
    academic_year_id = params[:initialize_year].to_i

    BookReceipt.initialize_with_student_books academic_year_id-1, academic_year_id
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_receipt
      @book_receipt = BookReceipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_receipt_params
      params.require(:book_receipt).permit(:book_copy_id, :academic_year_id, :student_id, :book_edition_id, :grade_section_id, :grade_level_id, :roster_no, :copy_no, :issue_date, :initial_condition_id, :return_condition_id, :barcode, :notes, :grade_section_code, :grade_subject_code, :course_id, :course_text_id, :active)
    end
end
