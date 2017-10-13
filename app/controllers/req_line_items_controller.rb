class ReqLineItemsController < ApplicationController
  before_action :set_req_line_item, only: [:show, :edit, :update, :destroy]

  # GET /req_line_items
  # GET /req_line_items.json
  def index
    @req_line_items = ReqLineItem.all
  end

  # GET /req_line_items/1
  # GET /req_line_items/1.json
  def show
  end

  # GET /req_line_items/new
  def new
    @req_line_item = ReqLineItem.new
  end

  # GET /req_line_items/1/edit
  def edit
  end

  # POST /req_line_items
  # POST /req_line_items.json
  def create
    @req_line_item = ReqLineItem.new(req_line_item_params)

    respond_to do |format|
      if @req_line_item.save
        format.html { redirect_to @req_line_item, notice: 'Req line item was successfully created.' }
        format.json { render :show, status: :created, location: @req_line_item }
      else
        format.html { render :new }
        format.json { render json: @req_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /req_line_items/1
  # PATCH/PUT /req_line_items/1.json
  def update
    respond_to do |format|
      if @req_line_item.update(req_line_item_params)
        format.html { redirect_to @req_line_item, notice: 'Req line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @req_line_item }
      else
        format.html { render :edit }
        format.json { render json: @req_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /req_line_items/1
  # DELETE /req_line_items/1.json
  def destroy
    @req_line_item.destroy
    respond_to do |format|
      format.html { redirect_to req_line_items_url, notice: 'Req line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_req_line_item
      @req_line_item = ReqLineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def req_line_item_params
      params.require(:req_line_item).permit(:requisition, :description,, :qty_reqd, :unit,, :est_price, :actual_price, :currency,, :notes,, :qty_ordered, :order_date, :qty_delivered, :delivery_date, :qty_accepted, :acceptance_date, :qty_rejected, :needed_by_date, :acceptance_notes,, :reject_notes)
    end
end
