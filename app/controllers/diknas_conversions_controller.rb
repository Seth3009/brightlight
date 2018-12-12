class DiknasConversionsController < ApplicationController
  before_action :set_diknas_conversion, only: [:show, :edit, :update, :destroy, :dry_run]

  # GET /diknas_conversions
  # GET /diknas_conversions.json
  def index
    authorize! :read, DiknasConversion 

    @diknas_conversions = DiknasConversion.all
        .includes([:diknas_course, :academic_year, :academic_term, :grade_level,
                   diknas_conversion_items: [:course, :academic_year, :academic_term]])
        .paginate(page: params[:page], per_page: 50)
    if params[:term].present?
      @diknas_conversions = @diknas_conversions.where(academic_term_id: params[:term])
      @academic_term = AcademicTerm.find params[:term]
    end
    if params[:grade].present?
      @diknas_conversions = @diknas_conversions.where(grade_level_id: params[:grade])
      @grade_level = GradeLevel.find params[:grade]
    end  
  end

  # GET /diknas_conversions/1
  # GET /diknas_conversions/1.json
  def show
    authorize! :read, DiknasConversion 
    @students = Student.joins(:diknas_report_cards)
                .where(diknas_report_cards: {grade_level: @diknas_conversion.grade_level, academic_term_id: @diknas_conversion.academic_term_id})
                .uniq.order(:name)
  end

  # GET /diknas_conversions/new
  def new
    authorize! :create, DiknasConversion 
    @diknas_conversion = DiknasConversion.new
  end

  # GET /diknas_conversions/1/edit
  def edit
    authorize! :update, DiknasConversion 
  end

  # POST /diknas_conversions
  # POST /diknas_conversions.json
  def create
    authorize! :create, DiknasConversion 
    @diknas_conversion = DiknasConversion.new(diknas_conversion_params)

    respond_to do |format|
      if @diknas_conversion.save
        format.html { redirect_to diknas_conversions_url, notice: 'Diknas conversion was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_conversion }
      else
        format.html { render :new }
        format.json { render json: @diknas_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_conversions/1
  # PATCH/PUT /diknas_conversions/1.json
  def update
    authorize! :update, DiknasConversion 
    respond_to do |format|
      if @diknas_conversion.update(diknas_conversion_params)
        format.html { redirect_to @diknas_conversion, notice: 'Diknas conversion was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_conversion }
      else
        format.html { render :edit }
        format.json { render json: @diknas_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_conversions/1
  # DELETE /diknas_conversions/1.json
  def destroy
    authorize! :destroy, DiknasConversion 
    @diknas_conversion.destroy
    respond_to do |format|
      format.html { redirect_to diknas_conversions_url, notice: 'Diknas conversion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dry_run
    authorize! :read, DiknasConversion 
    respond_to do |format|
      format.js { @student = Student.find params[:student_id] }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_conversion
      @diknas_conversion = DiknasConversion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_conversion_params
      params.require(:diknas_conversion).permit(:diknas_course_id, :grade_level_id, :academic_year_id, :academic_term_id, :weight, :notes, 
        diknas_conversion_items_attributes: [:id, :course_id, :academic_year_id, :academic_term_id, :weight, :notes, :_destroy],
        diknas_conversion_lists_attributes: [:id, :conversion_id, :weight, :notes, :_destroy])
    end
end
