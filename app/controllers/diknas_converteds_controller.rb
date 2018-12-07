class DiknasConvertedsController < ApplicationController
  before_action :set_diknas_converted, only: [:show, :edit, :update, :destroy]

  # GET /diknas_converteds
  # GET /diknas_converteds.json
  def index
    @diknas_converteds = DiknasConverted.all
    # authorize! :read, DiknasConverted    
    # respond_to do |format|
    #   format.html {
    #     items_per_page = 10  
    #     @diknas_converteds = DiknasReportCard.select(:student_id).group(:student_id)
    #     # @diknas_converted = DiknasConvertedItem.joins('left join diknas_converteds on diknas_converteds.id = diknas_converted_items.diknas_converted_id')                                          
    #                             # .paginate(page: params[:page], per_page: items_per_page)
    #   }
    # end
  end

  # GET /diknas_converteds/1
  # GET /diknas_converteds/1.json
  def show
  end

  # GET /diknas_converteds/new
  def new
    @diknas_converted = DiknasConverted.new
  end

  # GET /diknas_converteds/1/edit
  def edit
  end

  # POST /diknas_converteds
  # POST /diknas_converteds.json
  def create
    @diknas_converted = DiknasConverted.new(diknas_converted_params)

    respond_to do |format|
      if @diknas_converted.save
        format.html { redirect_to @diknas_converted, notice: 'Diknas converted was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_converted }
      else
        format.html { render :new }
        format.json { render json: @diknas_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_converteds/1
  # PATCH/PUT /diknas_converteds/1.json
  def update
    respond_to do |format|
      if @diknas_converted.update(diknas_converted_params)
        format.html { redirect_to @diknas_converted, notice: 'Diknas converted was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_converted }
      else
        format.html { render :edit }
        format.json { render json: @diknas_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_converteds/1
  # DELETE /diknas_converteds/1.json
  def destroy
    @diknas_converted.destroy
    respond_to do |format|
      format.html { redirect_to diknas_converteds_url, notice: 'Diknas converted was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #get /diknas_converteds/reports
  def reports
    @year_id = params[:year] || AcademicYear.current_id    
    @academic_year = AcademicYear.find @year_id
    @term_id = params[:term] || AcademicYear.current_id
    @aspek = ["Kedisiplinan","Kebersihan","Kesehatan","Tanggung Jawab", "Sopan Santun", "Percaya Diri","Kompetitif","Hubungan Sosial","Kejujuran","Pelaksanaan Ibadah Ritual"]
    @diknas = DiknasConvertedItem.where(diknas_converted_id:2).all
              .joins('left join diknas_conversions on diknas_conversions.id = diknas_converted_items.diknas_conversion_id')
              .joins('left join diknas_courses on diknas_courses.id = diknas_conversions.diknas_course_id').order('diknas_courses.name')                
              .joins('left join diknas_converteds on diknas_converteds.id = diknas_converted_items.diknas_converted_id')
              .joins('left join students on students.id = diknas_converteds.student_id')                  
              .joins('left join grade_levels on grade_levels.id = diknas_conversions.grade_level_id')
    @student = @diknas.first.diknas_converted.student
    # @grade = GradeSectionsStudent.where('grade_sections_students.student_id = ? and grade_sections_students.academic_year_id=?',@student.id,17)
            # .joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id').first
    @grade = @diknas.first.diknas_conversion.grade_level.name
    @grade_name = @grade.delete "Grade "
    # @grade_name = 12.roman
    respond_to do |format|
      format.html do
        @grade_level_ids = GradeLevel.all.order(:id).collect(&:id)
        @grade_sections = GradeSection.all.order(:grade_level_id, :id)
        @grade_sections_ids = @grade_sections.collect(&:id)
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_converted
      @diknas_converted = DiknasConverted.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_converted_params
      params.require(:diknas_converted).permit(:student_id, :academic_year_id, :academic_term_id, :grade_level_id, :notes, diknas_converted_items_attributes[:id, :diknas_conversion_id, :p_score, :t_score])
    end
end
