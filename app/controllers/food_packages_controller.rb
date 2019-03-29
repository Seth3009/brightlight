class FoodPackagesController < ApplicationController
  before_action :set_food_package, only: [:show, :edit, :update, :destroy]

  # GET /food_packages
  # GET /food_packages.json
  def index
    respond_to do |format|
      format.html {
        if params[:raw_food_id].present?
          @raw_food = RawFood.find(params[:raw_food_id])
          @food_packages = FoodPackage.where(raw_food_id:@raw_food.id).order(:packaging)     
        end
      }
      format.json { @food_packages = FoodPackage.search_index_query(params[:term]).all }
    end
  end

  # GET /food_packages/1
  # GET /food_packages/1.json
  def show
  end

  # GET /food_packages/new
  def new
    @raw_food = RawFood.find(params[:raw_food_id])    
    @food_package = @raw_food.food_packages.new    
    @measurement = unit_list(@raw_food.food_type)
  end

  # GET /food_packages/1/edit
  def edit
    @raw_food = RawFood.find(@food_package.raw_food_id)
    @measurement = unit_list(@raw_food.food_type)
  end

  # POST /food_packages
  # POST /food_packages.json
  def create
    @food_package = FoodPackage.new(food_package_params)

    respond_to do |format|
      if @food_package.save
        format.html { redirect_to raw_food_food_packages_path(@food_package.raw_food_id), notice: 'Food package was successfully created.' }
        format.json { render :show, status: :created, location: @food_package }
        format.js
      else
        format.html { redirect_to :back, alert: "Choose package unit"  }
        format.json { render json: @food_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_packages/1
  # PATCH/PUT /food_packages/1.json
  def update
    respond_to do |format|
      if @food_package.update(food_package_params)       
        format.html { redirect_to raw_food_food_packages_path(@food_package.raw_food_id), notice: 'Food package was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_package }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @food_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_packages/1
  # DELETE /food_packages/1.json
  def destroy
    FoodPackage.disable_item(@food_package.id)
    if @food_package.is_active? 
      @notice = 'food package disabled' 
    else 
      @notice = 'food package enabled.'
    end 
    # @food_package.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: @notice }
      format.json { head :no_content }
    end
  end

  def food_packages_list
    respond_to do |format|      
      format.json { @food_packages = FoodPackage.search_query(params[:term],params[:sp])}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_package
      @food_package = FoodPackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_package_params
      params.require(:food_package).permit(:packaging, :qty, :unit, :raw_food_id, :package_contents)
    end
end
