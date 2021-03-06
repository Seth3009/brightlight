class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json?section=1
  # GET /students.csv
  def index
    authorize! :read, Student
    respond_to do |format|
      format.html {
        items_per_page = 20
        if params[:search]
          @students = Student.where('UPPER(name) LIKE ?', "%#{params[:search].upcase}%").paginate(page: params[:page], per_page: items_per_page)
        else
          @students = Student.includes(:badge).paginate(page: params[:page], per_page: items_per_page)
        end
      }
      format.json {
        if params[:section].present?
          @students = Student.for_section(params[:section], year: params[:year] || AcademicYear.current_id)                        
        else
          @students = Student.current
                      .select('students.id, students.name, students.family_no, grade_sections_students.grade_section_id,
                        grade_sections_students.order_no, grade_sections.name as grade')
        end
        if params[:term].present?
          @students = @students.search_name(params[:term])
        end
      }
      format.csv {
        @students = Student.all
        render text: @students.to_csv
      }
    end
  end

  def student_tardy_list
    respond_to do |format|
      format.json {
        @students = Student.current
                    .select('students.id, students.name, students.family_no, grade_sections_students.grade_section_id,
                    grade_sections_students.order_no, grade_sections.name as grade , grade_sections.homeroom_id, employees.name as homeroom')
                    .order('students.name')
        if params[:term].present?
          @students = @students.student_tardy_search(params[:term])
        end
      }
    end
  end
  # GET /students/1
  # GET /students/1.json
  def show
    authorize! :read, Student
    @current_grade = @student.current_grade_section
    respond_to do |format|
      if @student
        format.html 
        format.json 
      else
        format.html { not_found }
        format.json { render json: {errors:"Invalid Card"}, status: :unprocessable_entity }
      end
    end
  end

  # GET /students/new
  def new
    authorize! :manage, Student
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    authorize! :update, Student
  end

  # POST /students
  # POST /students.json
  def create
    authorize! :manage, Student
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    authorize! :update, Student
    respond_to do |format|
      if @student.update(student_params)
        format.html {
          if student_params[:student_books_attributes].present?
            redirect_to student_student_books_path(@student), notice: 'Student book was successfully created.'
          else
            redirect_to @student, notice: 'Student was successfully created.'
          end
        }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html {
          if student_params[:student_books_attributes].present?
            redirect_to new_student_student_book_path(@student), alert: 'Book could not be added.'
          else
            render :edit
          end
        }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    authorize! :destroy, Student    
    respond_to do |format|
      if @student.destroy
        format.html { redirect_to students_url, notice: 'Student record was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to students_url, alert: @student.errors.full_messages.join('. ') }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end 
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      if params[:id].length > 9 
        @student = Student.joins(:badge).where(badges: {code: params[:id]}).take
      else
        @student = Student.where(id: params[:id]).includes([:student_admission_info]).first
      end      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :first_name, :last_name, :date_of_birth, :admission_no, :family_id, :gender,
        :blood_type, :nationality, :religion, :address_line1, :address_line2, :city, :state, :postal_code, :country,
        :mobile_phone, :home_phone, :email, :photo_uri, :status, :status_description, :is_active, :is_deleted, :student_no,
        :passport_no, :enrollment_date,
        {student_books_attributes: [:id, :student_id, :book_copy_id, :academic_year_id, :course_text_id, :copy_no, :grade_section_id,
            :grade_level_id, :course_id, :issue_date, :return_date, :initial_copy_condition_id, :end_copy_condition_id, :created_at,
            :updated_at, :barcode, :student_no, :roster_no, :grade_section_code, :grade_subject_code, :notes, :prev_academic_year_id,
            :book_edition_id, :_destroy]},
        {book_loans_attributes: [:id, :book_copy_id, :book_edition_id, :loan_status, :return_status, :barcode]})
    end
end
