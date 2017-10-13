class StockCategoriesController < ApplicationController
  before_action :set_stock_category, only: [:show, :edit, :update, :destroy]

  # GET /stock_categories
  # GET /stock_categories.json
  def index
    @stock_categories = StockCategory.all
  end

  # GET /stock_categories/1
  # GET /stock_categories/1.json
  def show
  end

  # GET /stock_categories/new
  def new
    @stock_category = StockCategory.new
  end

  # GET /stock_categories/1/edit
  def edit
  end

  # POST /stock_categories
  # POST /stock_categories.json
  def create
    @stock_category = StockCategory.new(stock_category_params)

    respond_to do |format|
      if @stock_category.save
        format.html { redirect_to @stock_category, notice: 'Stock category was successfully created.' }
        format.json { render :show, status: :created, location: @stock_category }
      else
        format.html { render :new }
        format.json { render json: @stock_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_categories/1
  # PATCH/PUT /stock_categories/1.json
  def update
    respond_to do |format|
      if @stock_category.update(stock_category_params)
        format.html { redirect_to @stock_category, notice: 'Stock category was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_category }
      else
        format.html { render :edit }
        format.json { render json: @stock_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_categories/1
  # DELETE /stock_categories/1.json
  def destroy
    @stock_category.destroy
    respond_to do |format|
      format.html { redirect_to stock_categories_url, notice: 'Stock category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_category
      @stock_category = StockCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_category_params
      params.require(:stock_category).permit(:name,, :code,, :description,, :type,, :is_active, :location)
    end
end
