class FoodSuppliersController < ApplicationController
  before_action :set_food_supplier, only: [:show, :edit, :update, :destroy]

  # GET /food_suppliers
  # GET /food_suppliers.json
  def index
    @food_suppliers = FoodSupplier.all
    if params[:search]
      @food_suppliers = @food_suppliers.where('UPPER(food_suppliers.supplier) LIKE ?', "%#{params[:search].upcase}%").order(:supplier)
    end
  end

  # GET /food_suppliers/1
  # GET /food_suppliers/1.json
  def show
  end

  # GET /food_suppliers/new
  def new
    @food_supplier = FoodSupplier.new
  end

  # GET /food_suppliers/1/edit
  def edit
  end

  # POST /food_suppliers
  # POST /food_suppliers.json
  def create
    @food_supplier = FoodSupplier.new(food_supplier_params)

    respond_to do |format|
      if @food_supplier.save
        format.html { redirect_to @food_supplier, notice: 'Food supplier was successfully created.' }
        format.json { render :show, status: :created, location: @food_supplier }
      else
        format.html { render :new }
        format.json { render json: @food_supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_suppliers/1
  # PATCH/PUT /food_suppliers/1.json
  def update
    respond_to do |format|
      if @food_supplier.update(food_supplier_params)
        format.html { redirect_to @food_supplier, notice: 'Food supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_supplier }
      else
        format.html { render :edit }
        format.json { render json: @food_supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_suppliers/1
  # DELETE /food_suppliers/1.json
  def destroy
    @food_supplier.destroy
    respond_to do |format|
      format.html { redirect_to food_suppliers_url, notice: 'Food supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_supplier
      @food_supplier = FoodSupplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_supplier_params
      params.require(:food_supplier).permit(:supplier, :address, :contact_person, :phone)
    end
end
