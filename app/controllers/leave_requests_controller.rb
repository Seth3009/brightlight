class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy, :cancel, :approve]
  before_action :set_employee, only: [:index, :new, :edit, :create, :update, :approve, :archives, :show]
  
  
  # GET /leave_requests
  # GET /leave_requests.json
  def index
    @dept = Department.find_by_code('HR')              
    @hrmanager = @dept.manager
    @hrvicemanager = @dept.vice_manager
    @leave_requests = LeaveRequest.with_employees_and_departments.active
    @own_leave_requests = @leave_requests.order(form_submit_date: :desc, updated_at: :desc)
                          .where('form_submit_date = ? or hr_approval IS ? or spv_approval IS ?',Date.today, nil, nil)
                          .empl(@employee)
    @own_count = @own_leave_requests.count
    @supv_approval_list = @leave_requests.spv(@employee)
                          .where('form_submit_date = ? or spv_approval IS ?',Date.today, nil) 
                          .order(form_submit_date: :asc, updated_at: :asc)                         
    @spv_count = @supv_approval_list.count
    @hr_approval_list = @leave_requests.hrlist
                        .where('hr_approval IS ?', nil)
                        .order(spv_date: :asc, form_submit_date: :asc, updated_at: :asc)
    @hr_count = @hr_approval_list.count
    
  end

  def archives
    # authorize! :approve, @leave_request if params[:page] == 'spv'
    # authorize! :validate, LeaveRequest if params[:page] == 'hr'

   
    @department = @employee.department       
    @dept = Department.find_by_code('HR')              
    @hrmanager = @dept.manager
    @vice_hrmanager = @dept.vice_manager
    @leave_requests = LeaveRequest.with_employees_and_departments

    if params[:view] == "hr" && @department.id == @dept.id
      @hr_approval_list = @leave_requests.hrlist_archive.where(start_date:(params[:ld] || Date.today)..(params[:lde] || Date.today))
                          .order("#{sort_column} #{sort_direction}").order(:form_submit_date)
    elsif params[:view] == "spv"
      @supv_approval_list = @leave_requests.spv_archive(@employee)
                            .where(start_date:(params[:ld] || Date.today)..(params[:lde] || Date.today)).order("#{sort_column} #{sort_direction}")
    else   
      @own_leave_requests = @leave_requests.empl(@employee).archive.order("#{sort_column} #{sort_direction}")
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
    if @leave_request.employee == @employee || can?(:update,@leave_request)    
      @commentable = @leave_request      
    else
      redirect_to leave_requests_url, alert: "Unauthorized page"
    end
    
    
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

    
    supervisor = @leave_request.employee.approver_id
    vice_supervisor = @leave_request.employee.approver_assistant_id
    @hrdept = Department.find_by_code('HR')
    hrmanager = @hrdept.manager_id
    hrvicemanager = @hrdept.vice_manager_id
    respond_to do |format|
      if @leave_request.save
        format.html do
          if params[:send]
            # if @leave_request.leave_type == "Special Leave"
            #   @sendto = "hr"              
            # else 
              @sendto = "spv"             
            # end          
            if @leave_request.send_for_approval(supervisor, vice_supervisor, hrmanager, hrvicemanager, @sendto, 'empl-submit')  && supervisor
              # @leave_request.auto_approve             
              redirect_to leave_requests_url, notice: 'Leave request has been saved and sent for approval.'               
            else
              redirect_to edit_leave_request_path(@leave_request), alert: "Cannot send for approval. Maybe approver field is blank?"
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
    authorize! :update, @leave_request
    @employees = Employee.all
    @requester = @leave_request.employee
    @supervisor = @requester.approver
    @vice_supervisor = @requester.approver_assistant
    @dept = Department.find_by_code('HR')              
    @hrmanager = @dept.manager
    @hrvicemanager = @dept.vice_manager
    
    respond_to do |format|
      if @leave_request.update(leave_request_params)
        format.html do
          if params[:send] 
            if params[:send] == 'empl_submit'
              approver = @supervisor
              vice_approver = @vice_supervisor
              hrmanager = @hrmanager
              hrvicemanager = @hrvicemanager
              # if @leave_request.leave_type == "Special Leave"
              #   send_to = 'hr'
              # else
                send_to = 'spv'
              # end
              if @leave_request.send_for_approval(approver, vice_approver, hrmanager, hrvicemanager, send_to,'empl-submit') && approver
                # @leave_request.auto_approve          
                redirect_to leave_requests_url, notice: 'Leave request has been saved and sent for approval.'
              else
                redirect_to edit_leave_request_path(@leave_request), alert: "Cannot send for approval. Maybe approver field is blank?"
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
    # @commentable = @leave_request    
    @requester = @leave_request.employee
    @supervisor = @requester.approver
    @vice_supervisor = @requester.approver_assistant
    @dept = Department.find_by_code('HR')              
    @hrmanager = @dept.manager
    @hrvicemanager = @dept.vice_manager
    if @employee != @supervisor && @employee != @hrmanager && @employee != @vice_supervisor && @employee != @hrvicemanager
        redirect_to leave_requests_url, alert: "You are not permitted to access this page" 
    elsif params[:page] != "spv" && params[:page] != "hr" && params[:page] != "employee"
      redirect_to leave_requests_url, alert: "unavailable page"
    end
  end

  # DELETE /leave_requests/1/cancel
  def cancel
     authorize! :cancel, @leave_request
    if params[:byemp] == "yes"
      @leave_request.cancel_by_employee
    else
      @leave_request.cancel     
    end
    redirect_to :back, notice: 'Leave request has been successfully canceled.'    
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
    def sortable_columns 
      [:form_submit_date, :start_date, :employee_name, :category,:leave_type]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_request
      @leave_request = LeaveRequest.includes(:employee, :comments => [:user]).find(params[:id])
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
      params.require(:leave_request).permit(:start_date, :end_date, :hour, :leave_type, :leave_note, :leave_subtitute, :subtitute_notes, :spv_approval, :spv_date, :spv_notes, :hr_approval, :hr_date, :hr_notes, :form_submit_date, :hr_staf_notes, :employee_id, :category, :leave_day, :start_time, :end_time, :employee_canceled,
                                            {comments_attributes: [:id, :title, :comment, :user_id, :commentable_id, :commentable_type, :role]} )
    end
end
