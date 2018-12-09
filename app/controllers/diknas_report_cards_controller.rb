class DiknasReportCardsController < ApplicationController
  before_action :set_diknas_report_card, only: [:edit, :update, :destroy]

  # GET /diknas_report_cards
  # GET /diknas_report_cards.json
  def index
    @diknas_report_cards = DiknasReportCard
                            .includes([:student, :academic_year, :academic_term, :grade_level])
                            .select([:student_id, :grade_level_id, :grade_section_id, :academic_year_id, :academic_term_id])
                            .group([:student_id, :grade_level_id, :grade_section_id, :academic_year_id, :academic_term_id])
                            .order([:academic_year_id, :academic_term_id, :grade_level_id])
                            .paginate(page: params[:page], per_page: 50)

    if params[:term].present?
      @diknas_report_cards = @diknas_report_cards.where(academic_term_id: params[:term])
      @academic_term = AcademicTerm.find params[:term]
    end
    if params[:grade].present?
      @diknas_report_cards = @diknas_report_cards.where(grade_level_id: params[:grade])
      @grade_level = GradeLevel.find params[:grade]
    end
  end

  # GET /diknas_report_cards/1
  # GET /diknas_report_cards/1.json
  def show
    @academic_year = AcademicYear.find params[:year]
    @student = Student.find params[:id]
    @grade_level = GradeLevel.find params[:grade]
    @grade_section = GradeSectionsStudent.where(academic_year: @academic_year.id, student_id: @student.id).take.grade_section
    @terms = @academic_year.academic_terms.order(:id).map &:id
    @records = DiknasReportCard.records_for student_id: @student.id, academic_year_id: @academic_year.id
  end

  # GET /diknas_report_cards/new
  def new
    @diknas_report_card = DiknasReportCard.new
  end

  # GET /diknas_report_cards/1/edit
  def edit
  end

  # POST /diknas_report_cards
  # POST /diknas_report_cards.json
  def create
    @diknas_report_card = DiknasReportCard.new(diknas_report_card_params)

    respond_to do |format|
      if @diknas_report_card.save
        format.html { redirect_to @diknas_report_card, notice: 'Diknas report card was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_report_card }
      else
        format.html { render :new }
        format.json { render json: @diknas_report_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_report_cards/1
  # PATCH/PUT /diknas_report_cards/1.json
  def update
    respond_to do |format|
      if @diknas_report_card.update(diknas_report_card_params)
        format.html { redirect_to @diknas_report_card, notice: 'Diknas report card was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_report_card }
      else
        format.html { render :edit }
        format.json { render json: @diknas_report_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_report_cards/1
  # DELETE /diknas_report_cards/1.json
  def destroy
    @diknas_report_card.destroy
    respond_to do |format|
      format.html { redirect_to diknas_report_cards_url, notice: 'Diknas report card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /import
  def import
    authorize! :create, DiknasReportCard
    uploaded_io = params[:filename] 
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_io.read)

      # diknas = DiknasReportCard.import_xlsx(file)
      # redirect_to diknas_report_cards_url, notice: "Import succeeded"
      if uploaded_io.content_type =~ /office.xlsx/ || uploaded_io.content_type =~ /officedocument/
        diknas = DiknasReportCard.import_xlsx(file)
        redirect_to diknas_report_cards_url, notice: "Import succeeded"
      else
        redirect_to diknas_report_cards_url, alert: 'Import failed: selected file is not an Excel file'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_report_card
      @diknas_report_card = DiknasReportCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_report_card_params
      params.require(:diknas_report_card).permit(:student_id, :grade_level_id, :grade_section_id, :academic_year_id, :academic_term_id, :course_belongs_to, :average, :notes)
    end
end
