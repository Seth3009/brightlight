class DiknasCoursesController < ApplicationController
  before_action :set_diknas_course, only: [:show, :edit, :update, :destroy]

  # GET /diknas_courses
  # GET /diknas_courses.json
  def index
    @diknas_courses = DiknasCourse.all.order(:number)
  end

  # GET /diknas_courses/1
  # GET /diknas_courses/1.json
  def show
  end

  # GET /diknas_courses/new
  def new
    @diknas_course = DiknasCourse.new
  end

  # GET /diknas_courses/1/edit
  def edit
  end

  # POST /diknas_courses
  # POST /diknas_courses.json
  def create
    @diknas_course = DiknasCourse.new(diknas_course_params)

    respond_to do |format|
      if @diknas_course.save
        format.html { redirect_to @diknas_course, notice: 'Diknas course was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_course }
      else
        format.html { render :new }
        format.json { render json: @diknas_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_courses/1
  # PATCH/PUT /diknas_courses/1.json
  def update
    respond_to do |format|
      if @diknas_course.update(diknas_course_params)
        format.html { redirect_to @diknas_course, notice: 'Diknas course was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_course }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @diknas_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_courses/1
  # DELETE /diknas_courses/1.json
  def destroy
    @diknas_course.destroy
    respond_to do |format|
      format.html { redirect_to diknas_courses_url, notice: 'Diknas course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_course
      @diknas_course = DiknasCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_course_params
      params.require(:diknas_course).permit(:number,:number2, :sort_num, :name, :notes)
    end
end
