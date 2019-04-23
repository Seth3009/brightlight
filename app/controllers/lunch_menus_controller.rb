class LunchMenusController < ApplicationController
  before_action :set_lunch_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_year, only: [:food_lists, :food_order, :new, :edit, :update]
  # GET /lunch_menus
  # GET /lunch_menus.json
  def index    
      @lunch_menus = LunchMenu.all
  end

  # GET /lunch_menus/1
  # GET /lunch_menus/1.json
  def show
  end

  # GET /lunch_menus/new
  def new
    @lunch_menu = LunchMenu.new
  end

  # GET /lunch_menus/1/edit
  def edit
  end

  # POST /lunch_menus
  # POST /lunch_menus.json
  def create
    @lunch_menu = LunchMenu.new(lunch_menu_params)

    respond_to do |format|
      if @lunch_menu.save
        format.html { redirect_to :back, notice: 'Lunch menu was successfully created.' }
        format.json { render :show, status: :created, location: @lunch_menu }
      else
        format.html { redirect_to :back, alert: 'Invalid Data' }
        format.json { render json: @lunch_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lunch_menus/1
  # PATCH/PUT /lunch_menus/1.json
  def update
    respond_to do |format|
      if @lunch_menu.update(lunch_menu_params)
        format.html { redirect_to @lunch_menu, notice: 'Lunch menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @lunch_menu }
      else
        format.html { render :edit }
        format.json { render json: @lunch_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lunch_menus/1
  # DELETE /lunch_menus/1.json
  def destroy
    @lunch_menu.destroy
    respond_to do |format|
      format.html { redirect_to lunch_menus_url, notice: 'Lunch menu was successfully destroyed.' }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end

  def food_lists
    @food_lists = LunchMenu.where(lunch_date: params[:d]).all    
    @food_pack = FoodPack.where(academic_year:@year).first    
  end

  def food_order        
    @food_pack = FoodPack.find_by_academic_year_id(@year)    
    @g1 = FoodPack.g1_g3(@food_pack)
    @g2 = FoodPack.g4_g6(@food_pack)
    @sol = FoodPack.sol(@food_pack)
    @sor = FoodPack.sor(@food_pack)
    @adult = @food_pack.employee
    
    @food_orders = RawFood.food_order((params[:sd] || Date.today).to_s,(params[:ed] || Date.today).to_s, @g1, @g2, @sol, @sor, @adult)
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunch_menu
      @lunch_menu = LunchMenu.find(params[:id])
    end

    def set_year
      @year = AcademicYear.current_id          
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lunch_menu_params
      params.require(:lunch_menu).permit(:lunch_date, :food_id, :adj_g1, :adj_g4, :adj_sol, :adj_sor, :adj_adult, :total_adj, :academic_year_id)
    end
end
