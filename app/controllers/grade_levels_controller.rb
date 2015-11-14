class GradeLevelsController < ApplicationController
  before_action :set_grade_level, only: [:show, :edit, :update, :destroy]

  # GET /grade_levels
  # GET /grade_levels.json
  def index
    @year_id = params[:year] || AcademicYear.current.first.id
    @academic_year = AcademicYear.find(@year_id)
    # This preloading cuts down the number of database calls to just 4 calls regardless the numbers of grade sections we have
    @grade_levels = GradeLevel.includes(grade_sections: [:homeroom, :academic_year]).where(grade_sections: {academic_year:@year_id})
  end

  # GET /grade_levels/1
  # GET /grade_levels/1.json
  def show
    @year_id = params[:year] || AcademicYear.current.first.id
    @academic_year = AcademicYear.find(@year_id)
    @grade_sections = @grade_level.grade_sections.with_academic_year_id(@year_id).includes([:academic_year, :homeroom])
  end

  # GET /grade_levels/new
  def new
    @grade_level = GradeLevel.new
    3.times { @grade_level.grade_sections.build }
  end

  # GET /grade_levels/1/edit
  def edit
    @year_id = params[:year] || AcademicYear.current.first.id
    @academic_year = AcademicYear.find(@year_id)
    @grade_sections = @grade_level.grade_sections.with_academic_year_id(@year_id).includes([:academic_year, :homeroom])
  end

  # POST /grade_levels
  # POST /grade_levels.json
  def create
    @grade_level = GradeLevel.new(grade_level_params)

    respond_to do |format|
      if @grade_level.save
        format.html { redirect_to @grade_level, notice: 'Grade level was successfully created.' }
        format.json { render :show, status: :created, location: @grade_level }
      else
        format.html { render :new }
        format.json { render json: @grade_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grade_levels/1
  # PATCH/PUT /grade_levels/1.json
  def update

    respond_to do |format|
      if @grade_level.update(grade_level_params)
        format.html { redirect_to @grade_level, notice: 'Grade level was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade_level }
      else
        format.html { render :edit }
        format.json { render json: @grade_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_levels/1
  # DELETE /grade_levels/1.json
  def destroy
    @grade_level.destroy
    respond_to do |format|
      format.html { redirect_to grade_levels_url, notice: 'Grade level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_level
      @grade_level = GradeLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_level_params
      params.require(:grade_level).permit(:name, :order_no, 
                                         {:grade_sections_attributes => [:name, :homeroom_id, :academic_year_id, :_destroy, :id]})
    end
end
