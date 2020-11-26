class FundRequestsController < ApplicationController
  before_action :set_fund_request, only: [:show, :edit, :update, :destroy]

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
    @fund_request = FundRequest.new
    @id = current_user.id
  end

  # GET /fund_requests/1/edit
  def edit
  end

  # POST /fund_requests
  # POST /fund_requests.json
  def create
    @fund_request = FundRequest.new(fund_request_params)

    respond_to do |format|
      if @fund_request.save
        format.html { redirect_to @fund_request, notice: 'Fund request was successfully created.' }
        format.json { render :show, status: :created, location: @fund_request }
      else
        format.html { render :new }
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_requests/1
  # PATCH/PUT /fund_requests/1.json
  def update
    respond_to do |format|
      if @fund_request.update(fund_request_params)
        format.html { redirect_to @fund_request, notice: 'Fund request was successfully updated.' }
        format.json { render :show, status: :ok, location: @fund_request }
      else
        format.html { render :edit }
        format.json { render json: @fund_request.errors, status: :unprocessable_entity }
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
      @fund_request = FundRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_request_params
      params.require(:fund_request).permit(:requester_id, :date_request, :date_needed, :description, :amount, :payment_type, :is_budgeted, :budget_notes, :is_spv_approved, :spv_approval_notes, :spv_approval_date, :is_hos_approved, :hos_approval_notes, :hos_approval_date, :receiver_id, :received_date)
    end
end
