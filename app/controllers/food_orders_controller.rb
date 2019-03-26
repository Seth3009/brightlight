class FoodOrdersController < ApplicationController
  before_action :set_food_order, only: [:show, :edit, :update, :destroy, :item_receive]
  
  # GET /food_orders
  # GET /food_orders.json
  def index
    @food_orders = FoodOrder.filter_query(params[:m] || Date.today.month.to_i, params[:y] || Date.today.year.to_i).order(:date_order,:created_at)
  end

  # GET /food_orders/1
  # GET /food_orders/1.json
  def show
    @food_order_items = FoodOrderItem.where(food_order_id:@food_order.id)
                        .joins('left join food_packages_food_suppliers on (food_packages_food_suppliers.food_supplier_id = ' + @food_order.food_supplier_id.to_s + ' and food_packages_food_suppliers.food_package_id = food_order_items.food_package_id)')
                        .select('food_order_items.*, food_packages_food_suppliers.*')
                        
  end

  # GET /food_orders/new
  def new
    @year = AcademicYear.current_id
    @food_order = FoodOrder.new
    @food_pack = FoodPack.find_by_academic_year_id(@year)    
    @g1 = FoodPack.g1_g3(@food_pack)
    @g2 = FoodPack.g4_g6(@food_pack)
    @sol = FoodPack.sol(@food_pack)
    @sor = FoodPack.sor(@food_pack)
    @adult = @food_pack.employee    
    @lunch_orders = RawFood.food_order((params[:sd] || Date.today).to_s,(params[:ed] || Date.today).to_s, @g1, @g2, @sol, @sor, @adult)                        
  end

  # GET /food_orders/1/edit
  def edit
  end

  # POST /food_orders
  # POST /food_orders.json
  def create
    @food_order = FoodOrder.new(food_order_params)

    respond_to do |format|
      if @food_order.save
        format.html { redirect_to food_orders_url, notice: 'Food order was successfully created.' }
        format.json { render :show, status: :created, location: @food_order }
      else
        format.html { render :new }
        format.json { render json: @food_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_orders/1
  # PATCH/PUT /food_orders/1.json
  def update
    respond_to do |format|
      if @food_order.update(food_order_params)
        format.html { redirect_to @food_order, notice: 'Food order was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_order }
      else
        format.html { render :edit }
        format.json { render json: @food_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_orders/1
  # DELETE /food_orders/1.json
  def destroy
    @food_order.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Food order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def non_stock_order
    @year = AcademicYear.current_id
    @food_order = FoodOrder.new
    @food_pack = FoodPack.find_by_academic_year_id(@year)    
    @g1 = FoodPack.g1_g3(@food_pack)
    @g2 = FoodPack.g4_g6(@food_pack)
    @sol = FoodPack.sol(@food_pack)
    @sor = FoodPack.sor(@food_pack)
    @adult = @food_pack.employee    
    @lunch_orders = RawFood.food_order_non_stock((params[:sd] || Date.today).to_s,(params[:ed] || Date.today).to_s, @g1, @g2, @sol, @sor, @adult,"all")    
    if params[:supplier].present? && params[:supplier] != 'all'
      @supplier_filter = FoodSupplier.find(params[:supplier])
      @lunch_orders = RawFood.food_order_non_stock((params[:sd] || Date.today).to_s,(params[:ed] || Date.today).to_s, @g1, @g2, @sol, @sor, @adult,params[:supplier])
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf:         "Order #{(@sol)}",
               disposition: 'inline',
               template:    'food_orders/non_stock_order.pdf.slim',
               layout:      'pdf.html',
               show_as_html: params.key?('screen')
      end
    end
  end

  def item_receive
    @food_order_items = FoodOrderItem.where(food_order_id:params[:id])
  end

  def update_multiple_item
    respond_to do |format|
      if FoodOrderItem.update(params[:food_order_items].keys, params[:food_order_items].values)
        format.html { redirect_to food_orders_path, notice: 'Food items was successfully updated.' }
      else
        format.html { render :back }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_order
      @food_order = FoodOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_order_params
      params.require(:food_order).permit(:date_order, :order_notes, :food_supplier_id, :is_completed,
                                        {food_order_items_attributes: [:id, :food_order_id, :food_package_id, :qty_order, :qty_received, :_destroy]})
    end
end
