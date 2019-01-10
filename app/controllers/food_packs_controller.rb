class FoodPacksController < ApplicationController
  before_action :set_food_pack, only: [:show, :edit, :update, :destroy]

  # GET /food_packs
  # GET /food_packs.json
  def index
    @food_packs = FoodPack.all
  end

  # GET /food_packs/1
  # GET /food_packs/1.json
  def show
  end

  # GET /food_packs/new
  def new
    @food_pack = FoodPack.new
  end

  # GET /food_packs/1/edit
  def edit
  end

  # POST /food_packs
  # POST /food_packs.json
  def create
    @food_pack = FoodPack.new(food_pack_params)

    respond_to do |format|
      if @food_pack.save
        format.html { redirect_to @food_pack, notice: 'Food pack was successfully created.' }
        format.json { render :show, status: :created, location: @food_pack }
      else
        format.html { render :new }
        format.json { render json: @food_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_packs/1
  # PATCH/PUT /food_packs/1.json
  def update
    respond_to do |format|
      if @food_pack.update(food_pack_params)
        format.html { redirect_to @food_pack, notice: 'Food pack was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_pack }
      else
        format.html { render :edit }
        format.json { render json: @food_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_packs/1
  # DELETE /food_packs/1.json
  def destroy
    @food_pack.destroy
    respond_to do |format|
      format.html { redirect_to food_packs_url, notice: 'Food pack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_pack
      @food_pack = FoodPack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_pack_params
      params.require(:food_pack).permit(:g1, :g2, :g3, :g4, :g5, :g6, :g7, :g8, :g9, :g10, :g11, :g12, :employee, :academic_year_id)
    end
end
