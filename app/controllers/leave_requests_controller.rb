class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy, :cancel, :approve]
  before_action :set_employee, only: [:index, :new, :edit, :create, :update, :approve, :archives]
  
  
  # GET /leave_requests
  # GET /leave_requests.json
  def index
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    @hrvicemanager = Employee.find_by_id(@dept.vice_manager_id)
    @department = Department.find_by_id(@employee.department_id) 
    @leave_requests = LeaveRequest.with_employees_and_departments
    @own_leave_requests = @leave_requests.order(form_submit_date: :desc, updated_at: :desc)
                          .where('form_submit_date = ? or hr_approval IS ? or form_submit_date = ?',Date.today, nil, nil)
                          .empl(@employee).active
    @own_count = @own_leave_requests.count
    @supv_approval_list = @leave_requests.active.spv(@employee).submitted
                          .where('form_submit_date = ? or spv_approval IS ?',Date.today, nil)
    @spv_count = @supv_approval_list.count
    @hr_approval_list = @leave_requests.hrlist
                        .where('hr_approval IS ?', nil)
    @hr_count = @hr_approval_list.count
    
  end

  def archives
    # authorize! :approve, @leave_request if params[:page] == 'spv'
    # authorize! :validate, LeaveRequest if params[:page] == 'hr'

   
    @department = Department.find_by_id(@employee.department_id)    
    @supervisor = Employee.find_by_id(@department.manager_id)
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    @leave_requests = LeaveRequest.with_employees_and_departments

    if params[:view] == "hr" && @department.id == @dept.id
      @hr_approval_list = @leave_requests.hrlist_archive
    elsif params[:view] == "spv" && @employee.id == @supervisor.id
      @supv_approval_list = @leave_requests.spv(@employee).submitted
                            .where(start_date:(params[:ld] || Date.today)..(params[:lde] || Date.today))
    else   
      @own_leave_requests = @leave_requests.empl(@employee).order(form_submit_date: :desc, updated_at: :desc)
                            .where(start_date:(params[:ld] || Date.today)..(params[:lde] || Date.today))
    end
   
    if params[:dept].present? && params[:dept] != 'all'
      @dept_filter = Department.find_by(code: params[:dept])
      @hr_approval_list = @hr_approval_list.where(departments: {code: params[:dept]})
    end
    
  end
  
  # GET /leave_requests/1
  # GET /leave_requests/1.json
  def show
    authorize! :read, @leave_request
  end

  # GET /leave_requests/new
  def new
    @leave_request = LeaveRequest.new
  end

  # GET /leave_requests/1/edit
  def edit
    authorize! :update, @leave_request
  end

  # POST /leave_requests
  # POST /leave_requests.json
  def create
    @leave_request = LeaveRequest.new(leave_request_params)
    authorize! :create, @leave_request

    @department = Department.find_by_id(@employee.department_id)
    supervisor = @department.manager_id
    vice_supervisor = @department.vice_manager_id
    @hrdept = Department.find_by_code('HR')
    hrmanager = @hrdept.manager_id
    hrvicemanager = @hrdept.vice_manager_id
    respond_to do |format|
      if @leave_request.save
        format.html do
          if params[:send]
            if @leave_request.leave_type == "Sick" || @leave_request.leave_type == "Special Leave"
              @sendto = "hr"              
            else 
              @sendto = "spv"             
            end          
            if @leave_request.send_for_approval(supervisor, vice_supervisor, hrmanager, hrvicemanager, @sendto, 'empl-submit')  
              @leave_request.auto_approve             
              redirect_to leave_requests_url, notice: 'Leave request has been saved and sent for approval.'               
            else
              redirect_to edit_leave_request_path(@leave_request), alert: "Cannot send for approval. Maybe supervisor field is blank? #{@requisition.requester.supervisor.name}"
            end
          else
            redirect_to leave_requests_url, notice: 'Leave request has been successfully created.' 
          end  
        end                     
        format.json { render :show, status: :created, location: @leave_request }
      else
        format.html { render :new }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /leave_requests/1
  # PATCH/PUT /leave_requests/1.json
  def update
    #authorize! :update, @leave_request
    
    @requester = Employee.find_by_id(@leave_request.employee_id)
    @department = Department.find_by_id(@requester.department_id)    
    @supervisor = Employee.find_by_id(@department.manager_id)
    @vice_supervisor = Employee.find_by_id(@department.vice_manager_id)
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    @hrvicemanager = Employee.find_by_id(@dept.vice_manager_id)
    
    respond_to do |format|
      if @leave_request.update(leave_request_params)
        format.html do
          if params[:send] 
            if params[:send] == 'empl_submit'
              approver = @supervisor
              vice_approver = @vice_supervisor
              hrmanager = @hrmanager
              hrvicemanager = @hrvicemanager
              if @leave_request.leave_type == "Sick" || @leave_request.leave_type == "Special Leave"
                send_to = 'hr'
              else
                send_to = 'spv'
              end
              if @leave_request.send_for_approval(approver, vice_approver, hrmanager, hrvicemanager, send_to,'empl-submit') 
                @leave_request.auto_approve          
                redirect_to leave_requests_url, notice: 'Leave request has been saved and sent for approval.'
              else
                redirect_to edit_leave_request_path(@leave_request), alert: "Cannot send for approval. Maybe supervisor field is blank? #{@requisition.requester.supervisor.name}"
              end                         
            elsif params[:send] == 'spv-app' || params[:send] == 'spv-den'              
              employee = @requester
              approver = @hrmanager   
              vice_approver = @hrvicemanager           
              if params[:send] == 'spv-app' 
                  status = true 
                  note = 'Leave request approval has been saved and sent to HR Department'
              else 
                  status = false
                  note = 'Leave request approval has been saved and sent back to Employee'
              end
              if @leave_request.send_approval(employee,approver, vice_approver,status,@leave_request.spv_notes,params[:send])
                redirect_to leave_requests_url, notice: note
              end              
            elsif params[:send] == 'hr-app' || params[:send] == 'hr-den'
              employee = @requester
              approver = @supervisor
              vice_approver = @vice_supervisor
              if params[:send] == 'hr-app' then status = true else status = false end    
              if @leave_request.send_approval(employee,approver, vice_approver,status,@leave_request.hr_notes,params[:send])
                redirect_to leave_requests_url, notice: 'Leave request approval has been saved and sent to employee'
              end
            end        
            
            
          else
            redirect_to leave_requests_url, notice: 'Leave request has been saved successfully.' 
          end  
        end  
        format.json { render :show, status: :ok, location: @leave_request }
      else
        format.html { render :edit }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /leave_requests/:id/approve/:page
  def approve
    authorize! :approve, @leave_request if params[:page] == 'spv'
    authorize! :validate, LeaveRequest if params[:page] == 'hr'

    @requester = Employee.find_by_id(@leave_request.employee_id)
    @department = Department.find_by_id(@requester.department_id)    
    @supervisor = Employee.find_by_id(@department.manager_id)
    @vice_supervisor = Employee.find_by_id(@department.vice_manager_id)
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    @hrvicemanager = Employee.find_by_id(@dept.vice_manager_id)
    if @employee != @supervisor && @employee != @hrmanager && @employee != @vice_supervisor && @employee != @hrvicemanager
        redirect_to leave_requests_url, alert: "You are not permitted to access this page" 
    elsif params[:page] != "spv" && params[:page] != "hr" && params[:page] != "employee"
      redirect_to leave_requests_url, alert: "unavailable page"
    end
  end

  # DELETE /leave_requests/1/cancel
  def cancel
    authorize! :cancel, @leave_request
    @leave_request.cancel
    redirect_to leave_requests_url, notice: 'Leave request has been successfully canceled.'
  end

  # DELETE /leave_requests/1
  # DELETE /leave_requests/1.json
  def destroy
    authorize! :destroy, @leave_request
    @leave_request.destroy
    respond_to do |format|
      format.html { redirect_to leave_requests_url, notice: 'Leave request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_request
      @leave_request = LeaveRequest.find(params[:id])
    end
    def set_employee
      if current_user.present?
          @employee = Employee.find_by_id(current_user.employee) 
      else
          redirect_to root_path
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_request_params
      params.require(:leave_request).permit(:start_date, :end_date, :hour, :leave_type, :leave_note, :leave_subtitute, :subtitute_notes, :spv_approval, :spv_date, :spv_notes, :hr_approval, :hr_date, :hr_notes, :form_submit_date, :hr_staf_notes, :employee_id, :category )
    end
end
