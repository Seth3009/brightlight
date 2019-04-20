class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :submit, :edit_account, :update, :update_approval, :update_account, :destroy, :approve]

  # GET /requisitions
  # GET /requisitions.json
  def index
    authorize! :read, Requisition
    @employee = current_user.employee
    approver_list = Approver.for_purchase_requests.where(employee: @employee)
    @i_am_approver = approver_list.present?
    if params[:my] == "action"
      @approved_requisitions = Requisition.approved.with_approval_by(@employee).order(:id)
      @pending_approval = Requisition.pending_approval.with_approval_by(@employee).order(:id)
      @draft_requisitions = Requisition.draft.with_approval_by(@employee).order(:id)
      @rejected_requisitions = Requisition.rejected.with_approval_by(@employee).order(:id)
    elsif params[:my] == "list" || params[:my].blank?
      @approved_requisitions = Requisition.approved.where(requester_id: @employee.id).order(:id)
      @pending_approval = Requisition.pending_approval.where(requester_id: @employee.id).order(:id)
      @draft_requisitions = Requisition.draft.where(requester_id: @employee.id).order(:id)
      @rejected_requisitions = Requisition.rejected.where(requester_id: @employee.id).order(:id)
    end
  end

  # GET /requisitions/list
  def list
    authorize! :process, Requisition
    @approved_requisitions = Requisition.approved.order(:id)
    @pending_approval = Requisition.pending_approval.order(:id)
    @draft_requisitions = Requisition.draft.order(:id)
    @rejected_requisitions = Requisition.rejected.order(:id)
    if params[:dept].present?
      @approved_requisitions = @approved_requisitions.where(department_id:params[:dept])
    end
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
    authorize! :read, @requisition
    @req_items = @requisition.req_items
    @level1_approvals = @requisition.approvals.level(1).where.not(approve: nil).includes(approver: [:employee])
    if @level1_approvals.blank? 
      @level1_approvals = @requisition.approvals.level(1).includes(approver: [:employee])
    end
    @budget_approvals = @requisition.approvals.where(level: [2,3]).includes(approver: [:employee])
    @commentable = @requisition
  end

  # GET /requisitions/new
  def new
    authorize! :create, Requisition
    @employee = current_user.employee
    if @employee.present?
      @department = @employee.department
      @accounts = Account.for_department_id(@employee.department_id) rescue []
    end
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
    authorize! :update, @requisition
    @employee = @requisition.requester || current_user.employee
    @manager = @employee.manager || @employee.supervisor
    @department = @requisition.department || @employee.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
  end

  def edit_account
    authorize! :update, @requisition
    @employee = @requisition.requester || current_user.employee
    @accounts = Account.for_department_id(@employee.department_id) rescue []
    @date = Date.parse(params[:date]) rescue nil
    @supplier = params[:supplier]
    @account = params[:account]
    @item = params[:item]
  end

  def update_account
    authorize! :update, @requisition
    @requisition.update(requisition_params)
    @order_item = OrderItem.with_po_records.where(id: params[:item]).take
    @date = Date.parse(params[:date]) rescue nil
    @supplier = params[:supplier]
    @account = params[:account]
    @item = params[:item]
    respond_to do |format|
      format.html { redirect_to report_purchase_orders_path params.merge(date: @date, supplier: @supplier, account: @account, item: @item).symbolize_keys }
    end
  end

  # POST /requisitions
  # POST /requisitions.json
  def create
    authorize! :create, Requisition
    @requisition = Requisition.new(requisition_params)
    @requisition.created_by = current_user
    @requisition.last_updated_by = current_user
    @requisition.status = Requisition.status_code :new
    respond_to do |format|
      if @requisition.save
        format.html do
          if params[:submit]
            redirect_to submit_requisition_path(@requisition)
          else
            redirect_to @requisition, notice: 'Purchase request draft has been successfully created.'
          end
        end
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { 
          @employee = @requisition.requester || current_user.employee
          @department = @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          render :new 
        }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /requisition/1/submit
  def submit
    authorize! :update, @requisition
    @requisition.submit!
    redirect_to @requisition, notice: 'Purchase request has been saved and sent for approval.' 
  end

  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    authorize! :update, @requisition
    @requisition.last_updated_by = current_user
    respond_to do |format|
      # @requisition.supv_approved_date ||= Date.today if requisition_params["is_supv_approved"] == "1"
      # @requisition.budget_approved_date ||= Date.today if requisition_params["is_budget_approved"] == "1"
      # @requisition.budget = @requisition.budget_item.try(:budget)
      if @requisition.update(requisition_params)
        # if params[:send]
        #   if params[:send] == 'supv'
        #     approver = @requisition.supervisor || @requisition.requester.supervisor || @requisition.requester.manager
        #   else
        #     approver = @requisition.budget_approver
        #   end
        #   if @requisition.send_for_approval(approver, params[:send])
        #     @message = 'Purchase request has been sent for approval.'
        #     format.html { redirect_to @requisition, notice: @message }
        #     format.json { render :show, status: :ok, location: @requisition }
        #     format.js
        #   else
        #     @error = 'Error: Purchase request cannot be sent for approval.'
        #     format.html { redirect_to edit_requisition_path(@requisition), alert: @error }
        #     format.json { render :show, status: :ok, location: @requisition }
        #     format.js
        #   end
        # elsif params[:approve] && @requisition.approved?
        #   @requisition.send_to_purchasing 
        #   @message = 'Purchase request has been sent for approval.'
        #   format.html { redirect_to @requisition, notice: @message }
        #   format.json { render :show, status: :ok, location: @requisition }
        #   format.js
        if params[:submit]
          format.html { redirect_to submit_requisition_path(@requisition) }
        else
          @message = 'Purchase request was successfully saved.'
          format.html { redirect_to @requisition, notice: @message }
          format.json { render :show, status: :ok, location: @requisition }
          format.js
        end
      else
        @error = 'Error updating purchase request.'
        format.html do 
          @employee = @requisition.requester || current_user.employee
          @department = @requisition.department || @employee.department
          @accounts = Account.for_department_id(@employee.department_id) rescue []
          @supervisors = Employee.supervisors.all
          render :edit 
        end
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /requisitions/1/approve
  def approve
    authorize! :approve, @requisition 
    @employee = @requisition.requester
    @department = @requisition.department
    @accounts = Account.for_department_id(@employee.department_id) rescue []
    @approvals = @requisition.approvals.joins(:approver).where(approvers: {employee_id: current_user.employee.try(:id)}).to_a
    @approvals.reject! {|a| a.level == 1 if @requisition.level2? }   # don't show level 1 approval if it's in level 2 already
  end

  # POST update_approval
  def update_approval
    authorize! :approve, @requisition 
    approvals = @requisition.approvals
    respond_to do |format|
      @requisition.update(requisition_params)
      if @requisition.level1?
        @requisition.supv_approved_date ||= Date.today
        if approvals.level(1).any? {|a| a.approve == true }
          @requisition.l1_approve!
        elsif approvals.level(1).any? {|a| a.approve == false }
          @requisition.reject!
        end
      elsif @requisition.level2?
        if approvals.level(2).any? {|a| a.approve == true }
          @requisition.l2_approve!
        elsif approvals.level(2).any? {|a| a.approve == false }
          @requisition.reject!
        end
      elsif @requisition.level3?
        if approvals.level(3).any? {|a| a.approve == true }
          @requisition.l3_approve!
        elsif approvals.level(3).any? {|a| a.approve == false }
          @requisition.reject!
        end
        @requisition.budget_approved_date ||= Date.today 
      end
      format.html { redirect_to @requisition }
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.json
  def destroy
    authorize! :destroy, @requisition
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Purchase request was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisition
      @requisition = Requisition.includes(:requester, :comments => [:user]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requisition_params
      params.require(:requisition).permit(:id, :req_no, :description, :is_budgeted, :budget_id, :budget_item_id, :budget_notes, :date_required, :date_requested, 
                                          :department_id, :requester_id, :supervisor_id, :notes, :req_appvl_notes, :total_amt, 
                                          :is_supv_approved, :is_budget_approved, :is_submitted, :sent_to_supv, :sent_to_purchasing, 
                                          :sent_for_bgt_approval, :is_rejected, :reject_reason, :active,
                                          :budget_approved_date, :supv_approved_date, :event_id, :class_budget_id, :budget_type,
                                          :budget_approver_id, :bgt_appvl_notes, :purch_receiver_id, :receive_notes,
                                          :created_by, :last_updated_by, :account_id,
                                          {req_items_attributes: [:id, :requisition_id, :description, :qty_reqd, :unit, :est_price, :actual_price, 
                                                                  :currency, :notes, :qty_ordered, :order_date, :qty_delivered, :delivery_date,
                                                                  :qty_accepted, :acceptance_date, :qty_rejected, :acceptance_notes, :reject_notes,
                                                                  :needed_by_date, :id, :created_by, :last_updated_by, :_destroy]},
                                          {comments_attributes: [:id, :title, :comment, :user_id, :commentable_id, :commentable_type, :role]},
                                          {approvals_attributes: [:id, :level, :approver_id, :approve, :sign_date, :notes]}
                                          )
    end
end
