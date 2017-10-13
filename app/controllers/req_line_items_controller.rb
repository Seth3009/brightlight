class ReqItemsController < ApplicationController
  before_action :set_req_item, only: [:show, :edit, :update, :destroy]

  # GET /req_items
  # GET /req_items.json
  def index
    @req_items = ReqItem.all
  end

  # GET /req_items/1
  # GET /req_items/1.json
  def show
  end

  # GET /req_items/new
  def new
    @req_item = ReqItem.new
  end

  # GET /req_items/1/edit
  def edit
  end

  # POST /req_items
  # POST /req_items.json
  def create
    @req_item = ReqItem.new(req_item_params)

    respond_to do |format|
      if @req_item.save
        format.html { redirect_to @req_item, notice: 'Req line item was successfully created.' }
        format.json { render :show, status: :created, location: @req_item }
      else
        format.html { render :new }
        format.json { render json: @req_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /req_items/1
  # PATCH/PUT /req_items/1.json
  def update
    respond_to do |format|
      if @req_item.update(req_item_params)
        format.html { redirect_to @req_item, notice: 'Req line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @req_item }
      else
        format.html { render :edit }
        format.json { render json: @req_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /req_items/1
  # DELETE /req_items/1.json
  def destroy
    @req_item.destroy
    respond_to do |format|
      format.html { redirect_to req_items_url, notice: 'Req line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_req_item
      @req_item = ReqItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def req_item_params
      params.require(:req_item).permit(:requisition, :description,, :qty_reqd, :unit,, :est_price, :actual_price, :currency,, :notes,, :qty_ordered, :order_date, :qty_delivered, :delivery_date, :qty_accepted, :acceptance_date, :qty_rejected, :needed_by_date, :acceptance_notes,, :reject_notes)
    end
end
