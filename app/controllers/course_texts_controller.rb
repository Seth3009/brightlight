class CourseTextsController < ApplicationController
  before_action :set_course, only: [:index, :filter, :new, :create, :init, :copy]
  before_action :set_course_text, only: [:edit, :update, :destroy]

  # GET /course_texts
  # GET /course_texts.json
  def index
    @course_texts = @course.course_texts.order(:book_category_id).includes(:book_title, :book_category)
    if params[:v] == 'block'
      @view_style = :block
      session[:view_style] = 'block'
    else
      @view_style = :list
      session[:view_style] = ''
    end
  end

  def filter
    @course_texts = @course.course_texts
      .where(book_category_id: params[:categories])
      .order(:book_category_id).includes(:book_title, :book_category)
    if params[:v] == 'block'
      @view_style = :block
      session[:view_style] = 'block'
    else
      @view_style = :list
      session[:view_style] = ''
    end
    render :index
  end

  # GET /course_texts/new
  def new
    authorize! :manage, CourseText
    @course_text = @course.course_texts.build
  end

  # GET /course_texts/1/edit
  def edit
    authorize! :update, @course_text
  end

  # POST /course_texts
  # POST /course_texts.json
  def create
    authorize! :manage, CourseText
    @course_text = @course.course_texts.new(course_text_params)

    respond_to do |format|
      if @course_text.save
        format.html { redirect_to course_course_texts_path(@course), notice: 'Course text was successfully created.' }
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
    authorize! :update, @course_text
    respond_to do |format|
      if @course_text.update(course_text_params)
        format.html { redirect_to course_course_texts_path(@course), notice: 'Course text was successfully updated.' }
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
    authorize! :destroy, @course_text
    @course_text.destroy
    respond_to do |format|
      format.html { redirect_to course_course_texts_path(@course), notice: 'Course text was successfully removed.' }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end

  def copy
    authorize! :update, @course
  end

  # POST /course_texts/1/init
  def init
    authorize! :update, @course

    @employee = Employee.find params[:employee_id]
    @year = AcademicYear.find params[:academic_year_id]
    @category = params[:book_category_id]
    
    respond_to do |format|
      if CourseText.create_from_book_loans(employee: @employee, academic_year: @year, category: @category, course: @course)
        format.html { redirect_to course_course_texts_path(@course), notice: 'Course text was successfully initialized.' }
        format.json { render :show, status: :ok, location: @course_text }
      else
        format.html { render :edit }
        format.json { render json: @course_text.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_text
      @course_text = CourseText.find(params[:id])
      @course = @course_text.course
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_text_params
      params.require(:course_text).permit(:course_id, :book_title_id, :book_edition_id, :book_category_id, :notes)
    end
end
