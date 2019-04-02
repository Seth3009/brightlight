class FoodDeliveriesController < ApplicationController
  before_action :set_food_delivery, only: [:show, :edit, :update, :destroy]

  # GET /food_deliveries
  # GET /food_deliveries.json
  def index
    @food_deliveries = FoodDelivery.filter_query(params[:m] || Date.today.month.to_i, params[:y] || Date.today.year.to_i).order(:delivery_date, :created_at)
  end

  # GET /food_deliveries/1
  # GET /food_deliveries/1.json
  def show
    @food_delivery_items = FoodDeliveryItem.where(food_delivery_id:@food_delivery.id)
  end

  # GET /food_deliveries/new
  def new
    @food_delivery = FoodDelivery.new
  end

  # GET /food_deliveries/1/edit
  def edit
    @food_delivery_items = FoodDeliveryItem.where(food_delivery_id:@food_delivery.id)
  end

  # POST /food_deliveries
  # POST /food_deliveries.json
  def create
    @food_delivery = FoodDelivery.new(food_delivery_params)

    respond_to do |format|
      if @food_delivery.save
        format.html { redirect_to food_deliveries_path, notice: 'Food delivery was successfully created.' }
        format.json { render :show, status: :created, location: @food_delivery }
      else
        format.html { render :new }
        format.json { render json: @food_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_deliveries/1
  # PATCH/PUT /food_deliveries/1.json
  def update
    respond_to do |format|
      if @food_delivery.update(food_delivery_params)
        format.html { redirect_to @food_delivery, notice: 'Food delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_delivery }
      else
        format.html { render :edit }
        format.json { render json: @food_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_deliveries/1
  # DELETE /food_deliveries/1.json
  def destroy
    @food_delivery.destroy
    respond_to do |format|
      format.html { redirect_to food_deliveries_url, notice: 'Food delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def update_multiple_item
    respond_to do |format|
      if FoodDeliveryItem.update(params[:food_delivery_items].keys, params[:food_delivery_items].values)
        format.html { redirect_to food_deliveries_path, notice: 'Food items was successfully updated.' }
      else
        format.html { render :back }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_delivery
      @food_delivery = FoodDelivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_delivery_params
      params.require(:food_delivery).permit(:delivery_date, :deliver_to, :notes,
                                    {food_delivery_items_attributes: [:food_delivery_id, :food_package_id, :qty, :_destroy]})
    end
end
