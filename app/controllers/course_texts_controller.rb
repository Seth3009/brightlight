class CourseTextsController < ApplicationController
  before_action :get_course 
  before_action :set_course_text, only: [:show, :edit, :update, :destroy]

  # GET /course_texts
  # GET /course_texts.json
  def index
    @course_texts = course.course_texts
  end

  # GET /course_texts/1
  # GET /course_texts/1.json
  def show
  end

  # GET /course_texts/new
  def new
    @course_text = course.course_texts.build
  end

  # GET /course_texts/1/edit
  def edit
  end

  # POST /course_texts
  # POST /course_texts.json
  def create
    @course_text = course.course_texts.new(course_text_params)

    respond_to do |format|
      if @course_text.save
        format.html { redirect_to @course_text, notice: 'Course text was successfully created.' }
        format.json { render :show, status: :created, location: @course_text }
      else
        format.html { render :new }
        format.json { render json: @course_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_texts/1
  # PATCH/PUT /course_texts/1.json
  def update
    respond_to do |format|
      if @course_text.update(course_text_params)
        format.html { redirect_to @course_text, notice: 'Course text was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_text }
      else
        format.html { render :edit }
        format.json { render json: @course_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_texts/1
  # DELETE /course_texts/1.json
  def destroy
    @course_text.destroy
    respond_to do |format|
      format.html { redirect_to course_texts_url, notice: 'Course text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_text
      @course_text = course.course_texts.find(params[:id])
    end

    def get_course
      course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_text_params
      params.require(:course_text).permit(:title, :author, :publisher, :image_url, :notes, :course_id)
    end
end
