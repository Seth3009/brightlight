class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy, :approve]

  # GET /requisitions
  # GET /requisitions.json
  def index
    authorize! :read, Requisition
    
    if can? :process, Requisition
      @approved_requisitions = Requisition.approved
      if params[:dept].present? && params[:dept] != 'all'
        dept = Department.where(code: params[:dept]).take
        @approved_requisitions = @approved_requisitions.where(department: dept)
      end
      @pending_approval = Requisition.pending_approval
    end
    
    @employee = current_user.employee
    @requisitions = Requisition.where(requester_id: @employee.id)

    if @employee.try(:is_manager?)
      @approver = current_user.employee
      @dept_requisitions   = Requisition.where(department: @employee.try(:department))
      @pending_my_approval   = @dept_requisitions.pending_supv_approval(@approver)
      @pending_budget_approval = Requisition.pending_budget_approval(@approver)
    end
  end

  # GET /requisitions/list
  def list
    authorize! :process, Requisition
    @pending_approval = Requisition.pending_approval
    @approved_requisitions = Requisition.approved #.joins(:req_items).where(req_items: {order_item: nil})
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
    authorize! :read, @requisition
    @req_items = @requisition.req_items
    @budget_line = "#{@requisition.budget_item.try(:description)} #{@requisition.budget_item.try(:month)}/#{@requisition.budget_item.try(:academic_year).try(:name)} "
    @commentable = @requisition
  end

  # GET /requisitions/new
  def new
    authorize! :create, Requisition
    @employee = current_user.employee
    if @employee.present?
      @department = @employee.department
      @budget = @employee.department.budgets.current.take rescue nil
      @budget_items = @budget.budget_items.order(:description, :year, :month) rescue []
      @manager = @employee.manager || @employee.supervisor
    end
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
    authorize! :update, @requisition
    @employee = @requisition.requester || current_user.employee
    @manager = @employee.manager || @employee.supervisor
    @supervisors = Employee.active.supervisors.all
    @budget = @employee.department.budgets.current.take rescue nil
    @budget_items = @budget.budget_items.where(academic_year: AcademicYear.current) rescue []
  end

  # POST /requisitions
  # POST /requisitions.json
  def create
    authorize! :create, Requisition
    @requisition = Requisition.new(requisition_params)
    @requisition.created_by = current_user
    @requisition.last_updated_by = current_user
    @budget_items = @budget.budget_items.where(academic_year: AcademicYear.current) rescue []
    respond_to do |format|
      if @requisition.save
        format.html do 
          if params[:send]
            approver = @requisition.supervisor || @requisition.requester.manager || @requisition.requester.supervisor
            if @requisition.send_for_approval(approver, 'supv')
              redirect_to @requisition, notice: 'Purchase request has been saved and sent for approval.' 
            else
              redirect_to edit_requisition_path(@requisition), alert: "Cannot send for approval. Maybe supervisor field is blank? #{@requisition.requester.supervisor.name}"
            end
          else
            redirect_to @requisition, notice: 'Purchase request has been successfully created.' 
          end 
        end
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { 
          @employee = @requisition.requester || current_user.employee
          @department = @employee.department
          @budget = @employee.department.budgets.current.take rescue nil
          @budget_items = @budget.budget_items.where(academic_year: AcademicYear.current) rescue nil
          render :new 
        }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    authorize! :update, @requisition
    @requisition.last_updated_by = current_user
    respond_to do |format|
      @requisition.supv_approved_date ||= Date.today if requisition_params["is_supv_approved"] == "1"
      @requisition.budget_approved_date ||= Date.today if requisition_params["is_budget_approved"] == "1"
      @requisition.budget = @requisition.budget_item.try(:budget)
      if @requisition.update(requisition_params)
        if params[:send]
          if params[:send] == 'supv'
            approver = @requisition.supervisor || @requisition.requester.supervisor || @requisition.requester.manager
          else
            approver = @requisition.budget_approver
          end
          if @requisition.send_for_approval(approver, params[:send])
            @message = 'Purchase request has been sent for approval.'
            format.html { redirect_to @requisition, notice: @message }
            format.json { render :show, status: :ok, location: @requisition }
            format.js
          else
            @error = 'Error: Purchase request cannot be sent for approval.'
            format.html { redirect_to edit_requisition_path(@requisition), alert: @error }
            format.json { render :show, status: :ok, location: @requisition }
            format.js
          end
        elsif params[:approve] && @requisition.approved?
          @requisition.send_to_purchasing 
          @message = 'Purchase request has been sent for approval.'
          format.html { redirect_to @requisition, notice: @message }
          format.json { render :show, status: :ok, location: @requisition }
          format.js
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
    authorize! :approve, @requisition if params[:appvl] == 'supv'
    authorize! :approve_budget, @requisition if params[:appvl] == 'budget'
    @employee = @requisition.requester
    @manager = @employee.manager || @employee.supervisor
    @supervisors = Employee.active.supervisors.all
    @budget = @employee.department.budgets.current.take rescue nil
    @budget_items = @budget.budget_items rescue []
    @button_state = !@requisition.is_budgeted && @requisition.is_supv_approved && !@requisition.is_budget_approved && @requisition.budget_approver_id
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
                                          :budget_approved_date, :supv_approved_date,
                                          :budget_approver_id, :bgt_appvl_notes, :purch_receiver_id, :receive_notes,
                                          :created_by, :last_updated_by,
                                          {req_items_attributes: [:id, :requisition_id, :description, :qty_reqd, :unit, :est_price, :actual_price, 
                                                                  :currency, :notes, :qty_ordered, :order_date, :qty_delivered, :delivery_date,
                                                                  :qty_accepted, :acceptance_date, :qty_rejected, :acceptance_notes, :reject_notes,
                                                                  :needed_by_date, :id, :created_by, :last_updated_by, :_destroy]},
                                          {comments_attributes: [:id, :title, :comment, :user_id, :commentable_id, :commentable_type, :role]}
                                          )
    end
end
