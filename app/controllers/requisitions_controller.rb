class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]

  # GET /requisitions
  # GET /requisitions.json
  def index
    authorize! :read, Requisition
    @requisitions = Requisition.all
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
    authorize! :read, @requisition
  end

  # GET /requisitions/new
  def new
    authorize! :create, Requisition
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
    authorize! :update, @requisition
    @employee = current_user.employee
    @supervisors = Employee.where('id in (select supervisor_id from employees where supervisor_id is not null)').all
  end

  # POST /requisitions
  # POST /requisitions.json
  def create
    authorize! :create, Requisition
    @requisition = Requisition.new(requisition_params)

    respond_to do |format|
      if @requisition.save
        format.html { redirect_to @requisition, notice: 'Requisition was successfully created.' }
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { render :new }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    authorize! :update, @requisition
    respond_to do |format|
      if @requisition.update(requisition_params)
        format.html { redirect_to @requisition, notice: 'Requisition was successfully updated.' }
        format.json { render :show, status: :ok, location: @requisition }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.json
  def destroy
    authorize! :destroy, @requisition
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisition
      @requisition = Requisition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requisition_params
      params.require(:requisition).permit(:req_no, :description, :is_budgeted, :budget_id, :budget_item_id, :date_required, :date_requested, :department_id, :requester_id, :supervisor_id, :supv_approval, :notes, :appvl_notes, :total_amt, :is_budget_approved, :is_submitted, :is_approved, :is_sent_to_supv, :is_sent_to_purchasing, :is_sent_for_bgt_approval, :is_rejected, :reject_reason, :active,
                                          {req_items_attributes: [:requisition_id, :description, :qty_reqd, :unit, :est_price, :actual_price, :notes, :date_needed, :budgetted, :budget_item_id, :budget_name, :bdgt_approved, :bdgt_notes, :bdgt_appvl_by_id]}
                                          )
    end
end
