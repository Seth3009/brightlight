class FoodOrderItemsController < ApplicationController
  before_action :set_food_order_item, only: [:show, :edit, :update, :destroy]

  # GET /food_order_items
  # GET /food_order_items.json
  def index
    @food_order_items = FoodOrderItem.all
  end

  # GET /food_order_items/1
  # GET /food_order_items/1.json
  def show
  end

  # GET /food_order_items/new
  def new
    @food_order_item = FoodOrderItem.new
  end

  # GET /food_order_items/1/edit
  def edit
  end

  # POST /food_order_items
  # POST /food_order_items.json
  def create
    @food_order_item = FoodOrderItem.new(food_order_item_params)

    respond_to do |format|
      if @food_order_item.save
        format.html { redirect_to @food_order_item, notice: 'Food order item was successfully created.' }
        format.json { render :show, status: :created, location: @food_order_item }
      else
        format.html { render :new }
        format.json { render json: @food_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_order_items/1
  # PATCH/PUT /food_order_items/1.json
  def update
    respond_to do |format|
      if @food_order_item.update(food_order_item_params)
        format.html { redirect_to @food_order_item, notice: 'Food order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_order_item }
      else
        format.html { render :edit }
        format.json { render json: @food_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_order_items/1
  # DELETE /food_order_items/1.json
  def destroy
    @food_order_item.destroy
    respond_to do |format|
      format.html { redirect_to food_order_items_url, notice: 'Food order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_order_item
      @food_order_item = FoodOrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_order_item_params
      params.require(:food_order_item).permit(:food_order_id, :food_package_id, :qty_order, :qty_received)
    end
end
