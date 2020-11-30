class FundRequestsController < ApplicationController
  before_action :set_fund_request, only: [:show, :edit, :submit, :update, :update_approval, :destroy, :approve]
  # before_action :set_fund_request, only: [:show, :edit, :update, :destroy]

  # GET /fund_requests
  # GET /fund_requests.json
  def index
    authorize! :read, Requisition
    @employee = current_user.employee
    approver_list = Approver.for_fund_requests.where(employee: @employee)
    @i_am_approver = approver_list.present?
    params[:my] = "action" if params[:my].blank? && @i_am_approver
    if params[:my] == "action"
      # @approved_requisitions = Requisition.approved.with_approval_by(@employee).order(id: :desc)
      @pending_approval = FundRequest.pending_approval.with_approval_by(@employee).order(id: :desc)
      # @draft_requisitions = Requisition.draft.with_approval_by(@employee).order(id: :desc)
      # @rejected_requisitions = Requisition.rejected.with_approval_by(@employee).order(id: :desc)
    elsif params[:my] == "list" || params[:my].blank?
      # @approved_requisitions = Requisition.approved.where(requester_id: @employee.id).order(id: :desc)
      @pending_approval = FundRequest.pending_approval.where(requester_id: @employee.id).order(id: :desc)
      # @draft_requisitions = Requisition.draft.where(requester_id: @employee.id).order(id: :desc)
      # @rejected_requisitions = Requisition.rejected.where(requester_id: @employee.id).order(id: :desc)
    end
    # @non_budgeted = FundRequest.approved.where(is_budgeted: false).order(id: :desc)
  end

  # GET /fund_requests/1
  # GET /fund_requests/1.json
  def show
  end

  # GET /fund_requests/new
  def new
    authorize! :create, FundRequest
    @employee = current_user.employee
    if @employee.present?
      @department = @employee.department
      # @accounts = Account.for_department_id(@employee.department_id) rescue []
    end
    @fund_request = FundRequest.new
  end

  # GET /fund_requests/1/edit
  def edit
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
          # @accounts = Account.for_department_id(@employee.department_id) rescue []
          render :new 
        }
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /requisition/1/submit
  def submit
    authorize! :update, @requisition
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
          format.html { redirect_to submit_requisition_path(@fund_request) }
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
          # @accounts = Account.for_department_id(@employee.department_id) rescue []
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
                                          :sent_for_bgt_approval, :sent_to_supv, :req_approver_id, :supervisor_id, :budget_approver_id, :department_id, :created_by, :last_updated_by,
                                          {comments_attributes: [:id, :title, :comment, :user_id, :commentable_id, :commentable_type, :role]},
                                          {approvals_attributes: [:id, :level, :approver_id, :approve, :sign_date, :notes]}
                                          )
    end
end
