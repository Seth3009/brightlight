class SuppliesStocksController < ApplicationController
  before_action :set_supplies_stock, only: [:show, :edit, :update, :destroy]

  # GET /supplies_stocks
  # GET /supplies_stocks.json
  def index
    @supplies_stocks = SuppliesStock.all
  end

  # GET /supplies_stocks/1
  # GET /supplies_stocks/1.json
  def show
  end

  # GET /supplies_stocks/new
  def new
    @supplies_stock = SuppliesStock.new
  end

  # GET /supplies_stocks/1/edit
  def edit
  end

  # POST /supplies_stocks
  # POST /supplies_stocks.json
  def create
    @supplies_stock = SuppliesStock.new(supplies_stock_params)

    respond_to do |format|
      if @supplies_stock.save
        format.html { redirect_to @supplies_stock, notice: 'Supplies stock was successfully created.' }
        format.json { render :show, status: :created, location: @supplies_stock }
      else
        format.html { render :new }
        format.json { render json: @supplies_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies_stocks/1
  # PATCH/PUT /supplies_stocks/1.json
  def update
    respond_to do |format|
      if @supplies_stock.update(supplies_stock_params)
        format.html { redirect_to @supplies_stock, notice: 'Supplies stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplies_stock }
      else
        format.html { render :edit }
        format.json { render json: @supplies_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies_stocks/1
  # DELETE /supplies_stocks/1.json
  def destroy
    @supplies_stock.destroy
    respond_to do |format|
      format.html { redirect_to supplies_stocks_url, notice: 'Supplies stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplies_stock
      @supplies_stock = SuppliesStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplies_stock_params
      params.require(:supplies_stock).permit(:trx_date, :trx_type, :qty, :trx_notes, :supply_id, :user_id, :warehouse_id)
    end
end
