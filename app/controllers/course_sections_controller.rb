class CourseSectionsController < ApplicationController
  before_action :set_course_section, only: [:show, :edit, :students, :add_students, :update, :destroy]
  # load_and_authorize_resource

  # GET /course_sections
  # GET /course_sections.json
  def index
    @course = Course.find(params[:course_id])
    items_per_page = 20
    if params[:grade_id]
      @course_sections = CourseSection.with_grade_level(params[:grade_id]).paginate(page: params[:page], per_page: items_per_page)
    elsif params[:course_id]
      @course_sections = @course.course_sections
    end
  end

  # GET /course_sections/1
  # GET /course_sections/1.json
  def show
    @course = @course_section.course
    @students = @course_section.students.with_grade_section
  end

  # GET /course_sections/1/edit
  def edit 
    authorize! :update, @course_section
  end

  # GET /course_sections/1/students
  def students
    authorize! :update, @course_section
    @academic_year = params[:year] ? AcademicYear.find(params[:year]) : AcademicYear.current
    @filterrific = initialize_filterrific(
      Student,
      params[:filterrific],
      select_options: {
        sorted_by: Student.options_for_sorted_by,
        with_grade_level_id: GradeLevel.options_for_select
      }
    ) or return

    @students = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # POST /course_sections
  # POST /course_sections.json
  def create
    authorize! :manage, CourseSection
    @course_section = CourseSection.new(course_section_params)

    respond_to do |format|
      if @course_section.save
        format.html { redirect_to @course_section, notice: 'Course section was successfully created.' }
        format.json { render :show, status: :created, location: @course_section }
      else
        format.html { render :new }
        format.json { render json: @course_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_sections/1
  # PATCH/PUT /course_sections/1.json
  def update
    authorize! :update, @course_section
    respond_to do |format|
      if @course_section.update(course_section_params)
        format.html { redirect_to @course_section, notice: 'Course section was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_section }
      else
        format.html { render :edit }
        format.json { render json: @course_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_sections/1
  # DELETE /course_sections/1.json
  def destroy
    authorize! :destroy, @course_section
    @course_section.destroy
    respond_to do |format|
      format.html { redirect_to course_sections_url, notice: 'Course section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_students
    authorize! :update, @course_section
    academic_year_id = params[:year]
    params[:add].map {|id,on| Student.find(id)}.each do |student|
      @roster = Roster.new(course_section: @course_section, student:student, academic_year_id: academic_year_id || current_academic_year_id)
      if @roster.save
        next
      else
        redirect_to edit_course_section_path, alert: 'Students already added' and return
      end
    end
    redirect_to course_section_path(@course_section, year:params[:year]), notice: 'Students successfully added'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_section
      @course_section = CourseSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_section_params
      params.require(:course_section).permit(:name, :instructor_id, :instructor2_id, :aide_id, :location_id)
    end
end
