class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :sortable_columns, only: [:index]
  
  # GET /employees
  # GET /employees.json
  def index
    authorize! :read, Employee
    respond_to do |format|
      format.html {
        @active_variable = {'All' => 'all', 'Active Only' => 'ao', 'Inactive Only' => 'io'}
        items_per_page = 20
        if (params[:vari].present? && params[:vari] == 'ao')
          @employees = Employee
              .joins('LEFT JOIN departments ON departments.id = employees.department_id') 
              .where(is_active: true)             
              .select('employees.*, departments.name as department')
              .order("#{sort_column} #{sort_direction}")
              .order('name')
              .includes(:department, :badge)
              .paginate(page: params[:page], per_page: items_per_page)
        elsif (params[:vari].present? && params[:vari] == 'io')
          @employees = Employee
              .joins('LEFT JOIN departments ON departments.id = employees.department_id') 
              .where(is_active: false)             
              .select('employees.*, departments.name as department')
              .order("#{sort_column} #{sort_direction}")
              .order('name')
              .includes(:department, :badge)
              .paginate(page: params[:page], per_page: items_per_page)
        else
          @employees = Employee
              .joins('LEFT JOIN departments ON departments.id = employees.department_id')              
              .select('employees.*, departments.name as department')
              .order("#{sort_column} #{sort_direction}")
              .order('name')
              .includes(:department, :badge)
              .paginate(page: params[:page], per_page: items_per_page)
        end
              
        if params[:search]
          @employees = @employees.where('UPPER(employees.name) LIKE ?', "%#{params[:search].upcase}%")       
        end
        
      }
      format.csv {
        @employees = Employee.all.where(is_active: true)
        render text: @employees.to_csv
      }
      format.json { @employees = Employee.search_query(params[:term]).active } 
    end   
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    authorize! :read, Employee 
    respond_to do |format|
      if @employee
        format.html
        format.json
      else
        format.html { not_found }
        format.json { render json: {errors:"Invalid Card"}, status: :unprocessable_entity }
      end
    end
  end

  # GET /employees/new
  def new
    authorize! :manage, Employee
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    authorize! :manage, Employee    
  end

  # POST /employees
  # POST /employees.json
  def create
    authorize! :manage, Employee
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    if employee_params[:book_loans_attributes].present?
      authorize! :update, Employee
    else
      authorize! :update, Employee
    end    
    respond_to do |format|
      if @employee.update(employee_params)        
        format.html do
          if employee_params[:book_loans_attributes].present?
            redirect_to employee_book_loans_path(@employee, year:params[:acad_year], book_catg:params[:book_catg]), notice: 'Book loan was successfully added.'
          else            
            redirect_to @employee, notice: 'Employee was successfully updated.'
          end
        end
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html do
          if employee_params[:book_loans_attributes].present?
            error_messages = @employee.errors.full_messages.flatten.first
            redirect_to new_employee_book_loans_path(@employee), alert: "Error:#{error_messages}"
          else
            render :edit
          end
        end
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    authorize! :destroy, Employee
    respond_to do |format|
      if @employee.destroy
        format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to employees_url, alert: @employee.errors.full_messages.join('. ') }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /employees/reminder
  def reminder
    EmployeeAwardReminder.sample_email.deliver_now
    @message = "Reminder sent through email"
    respond_to :js
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = if params[:id].length > 9 
                    Employee.joins(:badge).where(badges: {code: params[:id]}).take
                  else
                    Employee.find(params[:id])
                  end
    end   

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :first_name, :last_name, :gender, :date_of_birth, :place_of_birth,
        :joining_date, :job_title, :employee_number, :marital_status, :experience_year, :experience_month,
        :employment_status, :children_count, :home_address_line1, :home_address_line2, :home_city, :home_state,
        :home_country, :home_postal_code, :mobile_phone, :home_phone, :office_phone, :other_phone,
        :emergency_contact_number, :emergency_contact_name, :email, :photo_uri, :education_degree,
        :education_graduation_date, :education_school, :education_degree2, :education_graduation_date2,
        :education_school2, :supervisor_id, :department_id, :nationality, :blood_type, :is_active, :approver_id, :approver_assistant_id, :leaderships,
        {book_loans_attributes: [:id, :book_copy_id, :academic_year_id, :book_edition_id, :book_category_id, :book_title_id,
            :out_date, :due_date, :return_date, :loan_type_id, :user_id, :created_at, :updated_at, :barcode,
            :employee_id, :employee_no, :loan_status, :return_status, :notes, :grade_section_code, :grade_subject_code,
            :refno, :bkudid, :person_id, :_destroy]})
    end
    
    def sortable_columns 
      [:name, :job_title, :department, :is_active]
    end

end
