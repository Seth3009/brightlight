class FoodPackagesFoodSuppliersController < ApplicationController
  before_action :set_food_packages_food_supplier, only: [:show, :edit, :update, :destroy]

  # GET /food_packages_food_suppliers
  # GET /food_packages_food_suppliers.json
  def index
    @food_packages_food_suppliers = FoodPackagesFoodSupplier.all
  end

  # GET /food_packages_food_suppliers/1
  # GET /food_packages_food_suppliers/1.json
  def show
  end

  # GET /food_packages_food_suppliers/new
  def new 
    @food_supplier = FoodSupplier.find(params[:id])       
    @food_packages_food_supplier = FoodPackagesFoodSupplier.new
    @food_items = FoodPackage.select_food_item(@food_supplier.id)
  end

  # GET /food_packages_food_suppliers/1/edit
  def edit
    @food_items = FoodPackage.select_food_item(params[:id])
  end

  # POST /food_packages_food_suppliers
  # POST /food_packages_food_suppliers.json
  def create
    @food_packages_food_supplier = FoodPackagesFoodSupplier.new(food_packages_food_supplier_params)

    respond_to do |format|
      if @food_packages_food_supplier.save
        format.html { redirect_to :back, notice: 'Item added successfully' }
        format.json { render :show, status: :created, location: @food_packages_food_supplier }
      else
        format.html { redirect_to :back, alert: "Food Package can't be empty" }
        format.json { render json: @food_packages_food_supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_packages_food_suppliers/1
  # PATCH/PUT /food_packages_food_suppliers/1.json
  def update
    respond_to do |format|
      if @food_packages_food_supplier.update(food_packages_food_supplier_params)
        format.html { redirect_to :back, notice: 'Food item was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_packages_food_supplier }
      else
        format.html { render :edit }
        format.json { render json: @food_packages_food_supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_packages_food_suppliers/1
  # DELETE /food_packages_food_suppliers/1.json
  def destroy
    @food_packages_food_supplier.destroy
    respond_to do |format|
      format.html { redirect_to food_packages_food_suppliers_url, notice: 'Food packages food supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_packages_food_supplier
      @food_packages_food_supplier = FoodPackagesFoodSupplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_packages_food_supplier_params
      params.require(:food_packages_food_supplier).permit(:food_package_id, :food_supplier_id, :price, :date_update)
    end
end
