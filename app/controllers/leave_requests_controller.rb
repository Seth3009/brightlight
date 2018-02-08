class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy, :approve]
  before_action :set_user_id, only: [:index, :new, :edit, :create, :update, :approve]
  
  # GET /leave_requests
  # GET /leave_requests.json
  def index
    @department = Department.find_by_id(@employee.department_id) 
    @leave_requests = LeaveRequest.joins('left join employees on employees.id = leave_requests.employee_id') 
                                  .joins('left join departments on departments.id = employees.department_id')
    
  end

  # GET /leave_requests/1
  # GET /leave_requests/1.json
  def show
  end

  # GET /leave_requests/new
  def new
    @leave_request = LeaveRequest.new
  end

  # GET /leave_requests/1/edit
  def edit
  end

  # POST /leave_requests
  # POST /leave_requests.json
  def create
    @leave_request = LeaveRequest.new(leave_request_params)    
    @department = Department.find_by_id(@employee.department_id)
    #@supervisor = Employee.find_by_id(@department.manager_id)
    respond_to do |format|
      if @leave_request.save
        format.html do
          if params[:send]
            approver = Employee.find_by_id(@department.manager_id)            
            if @leave_request.send_for_approval(approver, 'empl_submit')              
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
    #@employee = Employee.find_by_id(@leave_request.employee_id)
    @department = Department.find_by_id(@employee.department_id)       
    respond_to do |format|
      if @leave_request.update(leave_request_params)
        format.html do
          if params[:send] 
            if params[:send] == 'empl_submit'
              approver = Employee.find_by_id(@department.manager_id)            
              if @leave_request.send_for_approval(approver, 'empl_submit')              
                redirect_to leave_requests_url, notice: 'Leave request has been saved and sent for approval.' 
              else
                redirect_to edit_leave_request_path(@leave_request), alert: "Cannot send for approval. Maybe supervisor field is blank? #{@requisition.requester.supervisor.name}"
              end                         
            elsif params[:send] == 'spv-app' || params[:send] == 'spv-den' 
              @dept = Department.find_by_code('HR')
              employee = @employee
              approver = Employee.find_by_id(@dept.manager_id)              
              if params[:send] == 'spv-app' then status = true else status = false end
                            
            elsif params[:send] == 'hr-app' || params[:send] == 'hr-den'
              employee = @employee
              approver = Employee.find_by_id(@department.manager_id)
              if params[:send] == 'hr-app' then status = true else status = false end
                          
            end
            if @leave_request.send_approval(employee,approver,status,params[:notes],params[:send])
              redirect_to leave_requests_url, notice: 'Leave request approval has been saved and sent to the employee'
            end
            
            
          else
            redirect_to leave_requests_url, notice: 'Leave request has been successfully created.' 
          end  
        end  
        format.json { render :show, status: :ok, location: @leave_request }
      else
        format.html { render :edit }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id) 
    @department = Department.find_by_id(@employee.department_id)
    @supervisor = Employee.find_by_id(@department.manager_id)
    
  end
  # DELETE /leave_requests/1
  # DELETE /leave_requests/1.json
  def destroy
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
    def set_user_id
      if current_user.present?
          @employee = Employee.find_by_id(current_user.employee) 
      else
          redirect_to root_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_request_params
      params.require(:leave_request).permit(:start_date, :end_date, :hour, :leave_type, :leave_note, :leave_subtitute, :subtitute_notes, :spv_approval, :spv_date, :spv_notes, :hr_approval, :hr_date, :hr_notes, :form_submit_date, :leave_attachment, :employee_id )
    end
end
