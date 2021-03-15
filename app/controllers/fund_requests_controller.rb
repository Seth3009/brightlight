class FundRequestsController < ApplicationController
  before_action :set_fund_request, only: [:show, :edit, :submit, :update, :update_approval, :destroy, :approve, :deliver, :deliver_fund, :settlement, :settlement_fund]
  # before_action :set_fund_request, only: [:show, :edit, :update, :destroy]

  # GET /fund_requests
  # GET /fund_requests.json
  def index
    authorize! :read, Requisition
    @employee = current_user.employee
    approver_list = Approver.for_fund_requests.where(employee: @employee)
    @i_am_finance = current_user.finance?
    @i_am_approver = approver_list.present?
    params[:my] = "action" if params[:my].blank? && @i_am_approver
    if params[:my] == "action"
      @approved_fund_requests = FundRequest.approved.not_delivered.with_approval_by(@employee).order(id: :desc)
      @pending_approval = FundRequest.pending_approval.with_approval_by(@employee).order(id: :desc)
      @draft_fund_requests = FundRequest.draft.with_approval_by(@employee).order(id: :desc)
      @rejected_fund_requests = FundRequest.rejected.with_approval_by(@employee).order(id: :desc)
      @delivered_fund_requests = FundRequest.delivered.with_approval_by(@employee).order(id: :desc)
      @settled_fund_requests = FundRequest.settled.with_approval_by(@employee).order(id: :desc)
    elsif params[:my] == "list" || params[:my].blank?
      @approved_fund_requests = FundRequest.approved.not_delivered.where(requester_id: @employee.id).order(id: :desc)
      @pending_approval = FundRequest.pending_approval.where(requester_id: @employee.id).order(id: :desc)
      @draft_fund_requests = FundRequest.draft.where(requester_id: @employee.id).order(id: :desc)
      @rejected_fund_requests = FundRequest.rejected.where(requester_id: @employee.id).order(id: :desc)
      @delivered_fund_requests = FundRequest.delivered.where(requester_id: @employee.id).order(id: :desc)
      @settled_fund_requests = FundRequest.settled.where(requester_id: @employee.id).order(id: :desc)
    end
    if @i_am_finance
      @approved_fund_requests = FundRequest.approved.not_delivered.order(id: :desc)
      @delivered_fund_requests = FundRequest.delivered.order(id: :desc)
      @settled_fund_requests = FundRequest.settled.order(id: :desc)
    end
    # @non_budgeted = FundRequest.approved.where(is_budgeted: false).order(id: :desc)
  end

  # GET /fund_requests/1
  # GET /fund_requests/1.json
  def show
    authorize! :read, @fund_request
    
    @level1_approvals = @fund_request.approvals.level(1).where.not(approve: nil).includes(approver: [:employee])
    if @level1_approvals.blank? 
      @level1_approvals = @fund_request.approvals.level(1).includes(approver: [:employee])
    end
    @budget_approvals = @fund_request.approvals.where(level: [2,3]).includes(approver: [:employee])
    @commentable = @fund_request
  end

  # GET /fund_requests/new
  def new
    authorize! :create, FundRequest
    @employee = current_user.employee
    if @employee.present?
      @department = @employee.department
      @accounts = Account.for_department_id(@employee.department_id) rescue []
    end
    @fund_request = FundRequest.new
  end

  # GET /fund_requests/1/edit
  def edit
    authorize! :update, @fund_request
    @employee = @fund_request.requester || current_user.employee
    @manager = @employee.manager || @employee.supervisor
    @department = @fund_request.department || @employee.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
  end

  # POST /fund_requests
  # POST /fund_requests.json
  def create
    authorize! :create, FundRequest
    @fund_request = FundRequest.new(fund_request_params)
    @fund_request.created_by = current_user
    @fund_request.last_updated_by = current_user
    @fund_request.status = FundRequest.status_code :new

    respond_to do |format|
      if @fund_request.save
        format.html do
          if params[:submit]
            redirect_to submit_fund_request_path(@fund_request)
          else
            redirect_to @fund_request, notice: 'Fund request draft has been successfully created.'
          end
        end
        format.json { render :show, status: :created, location: @fund_request }
      else
        format.html { 
          @employee = @fund_request.requester || current_user.employee
          @department = @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          render :new 
        }
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /requisition/1/submit
  def submit
    authorize! :update, @fund_request
    @fund_request.submit!
    redirect_to @fund_request, notice: 'Fund request has been saved and sent for approval.' 
  end

  # PATCH/PUT /fund_requests/1
  # PATCH/PUT /fund_requests/1.json
  def update
    authorize! :update, @fund_request
    @fund_request.last_updated_by = current_user
    respond_to do |format|
      if @fund_request.update(fund_request_params)
        if params[:submit]
          format.html { redirect_to submit_fund_request_path(@fund_request) }
        else
          @message = 'Fund request was successfully saved.'
          format.html { redirect_to @fund_request, notice: @message }
          format.json { render :show, status: :ok, location: @fund_request }
          format.js
        end
      else
        @error = 'Error updating fund request.'
        format.html do 
          @employee = @fund_request.requester || current_user.employee
          @department = @fund_request.department || @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          @supervisors = Employee.supervisors.all
          render :edit 
        end
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /requisitions/1/approve
  def approve
    authorize! :approve, @fund_request
    @employee = @fund_request.requester
    @department = @fund_request.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
    @approvals = @fund_request.approvals.joins(:approver)
                  .where(approvers: {employee_id: current_user.employee.try(:id)})
                  .where(approve: nil)
                  .to_a
    @approvals.reject! {|a| a.level == 1 if @fund_request.level2? }   # don't show level 1 approval if it's in level 2 already
  end

  # POST update_approval
  def update_approval
    authorize! :approve, @fund_request
    approvals = @fund_request.approvals
    respond_to do |format|
      @fund_request.update(fund_request_params)
      if @fund_request.level1?
        @fund_request.supv_approved_date ||= Date.today
        if approvals.level(1).any? {|a| a.approve == true }
          @fund_request.l1_approve!
        elsif approvals.level(1).any? {|a| a.approve == false }
          @fund_request.reject! 1
        end
      elsif @fund_request.level2?
        if approvals.level(2).any? {|a| a.approve == true }
          @fund_request.l2_approve!
        elsif approvals.level(2).any? {|a| a.approve == false }
          @fund_request.reject! 2
        end
      elsif @fund_request.level3?
        if approvals.level(3).any? {|a| a.approve == true }
          @fund_request.l3_approve!
        elsif approvals.level(3).any? {|a| a.approve == false }
          @fund_request.reject! 3
        end
        @fund_request.budget_approved_date ||= Date.today 
      end
      format.html { redirect_to @fund_request }
    end
  end

  # GET /fund_request/1/deliver
  def deliver
    authorize! :update, @fund_request
    @employee = @fund_request.requester
    @department = @fund_request.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
    
  end

  def deliver_fund
    authorize! :update, @fund_request
    respond_to do |format|
      if @fund_request.update(fund_request_params)
        @fund_request.notify_deliver
        format.html { redirect_to @fund_request, notice: "Fund request delivered successfully"}
      else
        @error = 'Error updating fund request.'
        format.html do 
          @employee = @fund_request.requester || current_user.employee
          @department = @fund_request.department || @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          @supervisors = Employee.supervisors.all
          render :edit 
        end
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /fund_request/1/settlement
  def settlement
    authorize! :update, @fund_request
    @employee = @fund_request.requester
    @department = @fund_request.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
    
  end

  def settlement_fund
    authorize! :update, @fund_request
    respond_to do |format|
      if @fund_request.update(fund_request_params)
        @fund_request.notify_settlement
        format.html { redirect_to @fund_request, notice: "Fund request settlement success"}
      else
        @error = 'Error updating fund request.'
        format.html do 
          @employee = @fund_request.requester || current_user.employee
          @department = @fund_request.department || @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          @supervisors = Employee.supervisors.all
          render :edit 
        end
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /fund_requests/1
  # DELETE /fund_requests/1.json
  def destroy
    @fund_request.destroy
    respond_to do |format|
      format.html { redirect_to fund_requests_url, notice: 'Fund request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund_request
      @fund_request = FundRequest.includes(:requester, :comments => [:user]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_request_params
      params.require(:fund_request).permit(:requester_id, :date_requested, :date_needed, :description, :amount, :is_cash, :transfer_to, :bank_name, :bank_account_number, :bank_city,
                                          :is_budgeted, :budget_notes, :is_spv_approved, :spv_approval_notes, :spv_approval_date, :is_hos_approved, :hos_approval_notes, :hos_approval_date, 
                                          :receiver_id, :received_date, :is_transfered, :is_submitted, :is_fin_canceled, :is_employee_canceled, 
                                          :account_id, :budget_type, :class_budget_id, :sent_for_bgt_approval, :sent_to_supv, :req_approver_id, :supervisor_id, :budget_approver_id, :department_id, :created_by, :last_updated_by,
                                          :budget_type, :class_budget_id, :supv_approved_date, :budget_approved_date, :total_expense, :is_settled, :settlement_date, :settlement_code,
                                          {comments_attributes: [:id, :title, :comment, :user_id, :commentable_id, :commentable_type, :role]},
                                          {approvals_attributes: [:id, :level, :approver_id, :approve, :sign_date, :notes]}
                                          )
    end
end
