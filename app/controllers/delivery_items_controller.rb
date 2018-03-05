class DeliveryItemsController < ApplicationController
  before_action :set_delivery_item, only: [:show, :edit, :update, :destroy]

  # GET /delivery_items
  # GET /delivery_items.json
  def index
    @delivery_items = DeliveryItem.all
  end

  # GET /delivery_items/1
  # GET /delivery_items/1.json
  def show
  end

  # GET /delivery_items/new
  def new
    @delivery_item = DeliveryItem.new
  end

  # GET /delivery_items/1/edit
  def edit
  end

  # POST /delivery_items
  # POST /delivery_items.json
  def create
    @delivery_item = DeliveryItem.new(delivery_item_params)

    respond_to do |format|
      if @delivery_item.save
        format.html { redirect_to @delivery_item, notice: 'Delivery item was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_item }
      else
        format.html { render :new }
        format.json { render json: @delivery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_items/1
  # PATCH/PUT /delivery_items/1.json
  def update
    respond_to do |format|
      if @delivery_item.update(delivery_item_params)
        format.html { redirect_to @delivery_item, notice: 'Delivery item was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_item }
      else
        format.html { render :edit }
        format.json { render json: @delivery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_items/1
  # DELETE /delivery_items/1.json
  def destroy
    @delivery_item.destroy
    respond_to do |format|
      format.html { redirect_to delivery_items_url, notice: 'Delivery item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_item
      @delivery_item = DeliveryItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_item_params
      params.require(:delivery_item).permit(:delivery_id, :order_item, :quantity, :unit, :accepted_by_id, :accepted_date, 
        :checked_by_id, :checked_date, :notes, :is_accepted, :is_rejected, :reject_notes, :accept_notes)
    end
end
