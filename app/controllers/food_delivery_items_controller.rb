class FoodDeliveryItemsController < ApplicationController
  before_action :set_food_delivery_item, only: [:show, :edit, :update, :destroy]

  # GET /food_delivery_items
  # GET /food_delivery_items.json
  def index
    @food_delivery_items = FoodDeliveryItem.all
  end

  # GET /food_delivery_items/1
  # GET /food_delivery_items/1.json
  def show
  end

  # GET /food_delivery_items/new
  def new
    @food_delivery_item = FoodDeliveryItem.new
  end

  # GET /food_delivery_items/1/edit
  def edit
  end

  # POST /food_delivery_items
  # POST /food_delivery_items.json
  def create
    @food_delivery_item = FoodDeliveryItem.new(food_delivery_item_params)

    respond_to do |format|
      if @food_delivery_item.save
        format.html { redirect_to @food_delivery_item, notice: 'Food delivery item was successfully created.' }
        format.json { render :show, status: :created, location: @food_delivery_item }
      else
        format.html { render :new }
        format.json { render json: @food_delivery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_delivery_items/1
  # PATCH/PUT /food_delivery_items/1.json
  def update
    respond_to do |format|
      if @food_delivery_item.update(food_delivery_item_params)
        format.html { redirect_to @food_delivery_item, notice: 'Food delivery item was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_delivery_item }
      else
        format.html { render :edit }
        format.json { render json: @food_delivery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_delivery_items/1
  # DELETE /food_delivery_items/1.json
  def destroy
    @food_delivery_item.destroy
    respond_to do |format|
      format.html { redirect_to food_delivery_items_url, notice: 'Food delivery item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_delivery_item
      @food_delivery_item = FoodDeliveryItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_delivery_item_params
      params.require(:food_delivery_item).permit(:food_delivery_id, :food_package_id, :qty)
    end
end
