class RawFoodsController < ApplicationController
  before_action :set_raw_food, only: [:show, :edit, :update, :destroy]

  # GET /raw_foods
  # GET /raw_foods.json
  def index
    @raw_foods = RawFood.all
  end

  # GET /raw_foods/1
  # GET /raw_foods/1.json
  def show
    @food_packages = FoodPackage.where(raw_food_id:@raw_food)
  end

  # GET /raw_foods/new
  def new
    @raw_food = RawFood.new
  end

  # GET /raw_foods/1/edit
  def edit
  end

  # POST /raw_foods
  # POST /raw_foods.json
  def create
    @raw_food = RawFood.new(raw_food_params)

    respond_to do |format|
      if @raw_food.save
        format.html { redirect_to @raw_food, notice: 'Raw food was successfully created.' }
        format.json { render :show, status: :created, location: @raw_food }
      else
        format.html { render :new }
        format.json { render json: @raw_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_foods/1
  # PATCH/PUT /raw_foods/1.json
  def update
    respond_to do |format|
      if @raw_food.update(raw_food_params)
        format.html { redirect_to @raw_food, notice: 'Raw food was successfully updated.' }
        format.json { render :show, status: :ok, location: @raw_food }
      else
        format.html { render :edit }
        format.json { render json: @raw_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_foods/1
  # DELETE /raw_foods/1.json
  def destroy
    @raw_food.destroy
    respond_to do |format|
      format.html { redirect_to raw_foods_url, notice: 'Raw food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_food
      @raw_food = RawFood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_food_params
      params.require(:raw_food).permit(:name, :is_stock, :is_active,
                                {:food_packages_attributes => [:id, :packaging, :qty, :unit, :raw_food_id, :_destroy]})
    end
end
