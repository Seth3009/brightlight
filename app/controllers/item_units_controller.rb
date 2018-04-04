class ItemUnitsController < ApplicationController
  before_action :set_item_unit, only: [:show, :edit, :update, :destroy]

  # GET /item_units
  # GET /item_units.json
  def index
    @item_units = ItemUnit.all
  end

  # GET /item_units/1
  # GET /item_units/1.json
  def show
  end

  # GET /item_units/new
  def new
    @item_unit = ItemUnit.new
  end

  # GET /item_units/1/edit
  def edit
  end

  # POST /item_units
  # POST /item_units.json
  def create
    @item_unit = ItemUnit.new(item_unit_params)

    respond_to do |format|
      if @item_unit.save
        format.html { redirect_to item_units_path, notice: 'Item unit was successfully created.' }
        format.json { render :show, status: :created, location: @item_unit }
      else
        format.html { render :new }
        format.json { render json: @item_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_units/1
  # PATCH/PUT /item_units/1.json
  def update
    respond_to do |format|
      if @item_unit.update(item_unit_params)
        format.html { redirect_to item_units_path, notice: 'Item unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_unit }
      else
        format.html { render :edit }
        format.json { render json: @item_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_units/1
  # DELETE /item_units/1.json
  def destroy
    @product = Product.where('item_unit_id = ?',@item_unit.id).first
    if @product.nil?
      @item_unit.destroy
      respond_to do |format|
        format.html { redirect_to item_units_url, notice: 'Item unit was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to item_units_url, notice: 'Cannot delete this unit, used by some products' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_unit
      @item_unit = ItemUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_unit_params
      params.require(:item_unit).permit(:name, :abbreviation)
    end
end
