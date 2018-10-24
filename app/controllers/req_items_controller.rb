class ReqItemsController < ApplicationController
  before_action :set_req_item, only: [:show]

  # GET /req_items
  # GET /req_items.json
  def index
    @req_items = ReqItem.all.includes(requisition: [:requester, :department])
    if params[:filter] == "incomplete"
      @req_items = @req_items.incomplete
    end
    respond_to :json
  end

  # GET /req_items/1
  # GET /req_items/1.json
  def show
    respond_to :json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_req_item
      @req_item = ReqItem.includes(requisition: [:requester, :department]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def req_item_params
      params.require(:req_item).permit(:requisition_id, :description, :qty_reqd, :unit, :est_price, :actual_price, :notes, :date_needed, :budgetted, :budget_item_id, :budget_name, :bdgt_approved, :bdgt_notes, :bdgt_appvl_by_id)
    end
end
