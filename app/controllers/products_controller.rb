class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :stock_card]
  

  # GET /products
  # GET /products.json
  def index
    authorize! :read, Product
    respond_to do |format|
      format.html {
        items_per_page = 20
        if params[:search]
          @products = Product.all.where('UPPER(name) LIKE ?', "%#{params[:search].upcase}%").paginate(page: params[:page], per_page: items_per_page).order("#{sort_column} #{sort_direction}")
        else
          @products = Product.all.paginate(page: params[:page], per_page: items_per_page).order("#{sort_column} #{sort_direction}")
        end
      }
      
      format.csv {
        @products = Product.all.order(:name)
        render text: @products.to_csv
      }
      format.json { @products = Product.search_query(params[:term]).active } 
    end    
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.joins('left join item_units on item_units.id = products.item_unit_id')
              .where('products.barcode = ?', params[:barcode])
              .select('products.*,item_units.name as unit').first
  end

  # GET /products/new
  def new
    authorize! :manage, Product
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    authorize! :manage, Product
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
        format.js
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }        
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize! :manage, Product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize! :manage, Product
    Product.disable_item(@product.id)
    if @product.is_active? 
      @notice = 'Product was successfully disabled.' 
    else 
      @notice = 'Product was successfully enabled.'
    end 
    #@product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: @notice}
      format.json { head :no_content }
    end
  end

  #get products/supplies_stocks
  def supplies_stocks
    authorize! :read, Product
    @supplies_stocks = Product.select('products.*, (sum(CASE WHEN in_out =' + "'IN'" + ' THEN qty ELSE 0 END) - sum(CASE WHEN in_out =' + "'OUT'" + ' THEN qty ELSE 0 END)) as stock')
                      .joins('left join supplies_transaction_items on supplies_transaction_items.product_id = products.id')
                      .group('products.id').order('code')
                      
    respond_to do |format|
      format.html
      format.pdf do
        render pdf:         "Supplies_Stock_#{Date.current()}",
               disposition: 'inline',
               template:    'products/supplies_stocks.pdf.slim',
               layout:      'pdf.html',
               show_as_html: params.key?('screen')
      end
    end                  
  end

  def stock_card
    authorize! :read, Product
    @products = Product.all
    @stocks = Product.joins('left join supplies_transaction_items on supplies_transaction_items.product_id = products.id')
                      .joins('left join supplies_transactions on supplies_transactions.id = supplies_transaction_items.supplies_transaction_id')
                      .joins('left join employees on employees.id = supplies_transactions.employee_id')
                      .select("employees.name, transaction_date at time zone 'utc' at time zone 'localtime' as date, supplies_transaction_items.in_out as type, supplies_transaction_items.qty, products.min_stock ")
                      .where('products.id = ?',params[:id]).order('date')                      
  end

  private
   
    # Enable Sort column
    def sortable_columns 
      [:code, :name]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product 
      @product = params[:barcode] ? Product.find_by(barcode:params[:id]) : Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code, :name, :price, :min_stock, :max_stock, :stock_type, :item_unit_id, :item_category_id, :is_active, :img_url, :packs, :packs_unit, :barcode)
    end
end
