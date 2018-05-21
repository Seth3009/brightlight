class SuppliesTransactionsController < ApplicationController
  before_action :set_supplies_transaction, only: [:show, :destroy]

  # GET /supplies_transactions
  # GET /supplies_transactions.json
  def index
    authorize! :read, SuppliesTransaction    
    respond_to do |format|
      format.html {
        items_per_page = 20
        if params[:m] && params[:y]
          @supplies_transactions = SuppliesTransaction.filter_query(params[:m], params[:y])
                                  .paginate(page: params[:page], per_page: items_per_page).order("transaction_date DESC, created_at Desc")
        else
          if params[:trx_date].present?
            @supplies_transactions = SuppliesTransactionItem.joins('left join supplies_transactions on supplies_transactions.id = supplies_transaction_items.supplies_transaction_id')                                          
                                          .where("transaction_date = ?", params[:trx_date])
                                          .paginate(page: params[:page], per_page: items_per_page).order("transaction_date DESC, created_at Desc")
          else
            redirect_to supplies_transactions_url(trx_date: Date.today,view:'daily')
          end
        end       
      }
    end
  end

  # GET /supplies_transactions/1
  # GET /supplies_transactions/1.json
  def show
    @supplies_transaction_item = SuppliesTransactionItem.where(supplies_transaction_id: @supplies_transaction).all
  end

  # GET /supplies_transactions/new
  def new
    authorize! :manage, SuppliesTransaction
    @product = Product.all
    @supplies_transaction = SuppliesTransaction.new
  end

  # POST /supplies_transactions
  # POST /supplies_transactions.json
  def create
    authorize! :manage, SuppliesTransaction
    @supplies_transaction = SuppliesTransaction.new(supplies_transaction_params)

    respond_to do |format|
      if @supplies_transaction.save
        format.html { redirect_to supplies_transactions_url, notice: 'Supplies transaction was successfully created.' }
        format.json { render :show, status: :created, location: @supplies_transaction }
      else
        format.html { render new_supplies_transaction_path }
        format.json { render json: @supplies_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies_transactions/1
  # DELETE /supplies_transactions/1.json
  def destroy
    authorize! :manage, SuppliesTransaction
    authorize! :manage, SuppliesTransactionItem
    @supplies_transaction.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Supplies transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recap       
    authorize! :read, SuppliesTransaction
    if params[:m].present? && params[:y].present?     
      @supplies_transaction_items = SuppliesTransactionItem
        .joins("left join products on products.id = supplies_transaction_items.product_id")
        .joins("left join item_units on item_units.id = products.item_unit_id")
        .joins("left join (select product_id, sum(qty) as qty_in from supplies_transaction_items LEFT JOIN supplies_transactions ON supplies_transactions.id = supplies_transaction_items.supplies_transaction_id where in_out='IN' and EXTRACT(MONTH from transaction_date) = " + params[:m] + " and EXTRACT(YEAR from transaction_date) = " + params[:y] + " group by product_id) as a on a.product_id = supplies_transaction_items.product_id")
        .joins("left join (select product_id, sum(qty) as qty_out from supplies_transaction_items LEFT JOIN supplies_transactions ON supplies_transactions.id = supplies_transaction_items.supplies_transaction_id where in_out='OUT' and EXTRACT(MONTH from transaction_date) = " + params[:m] + " and EXTRACT(YEAR from transaction_date) = " + params[:y] + " group by product_id) as b on b.product_id = supplies_transaction_items.product_id")
        .joins('left join supplies_transactions on supplies_transactions.id = supplies_transaction_items.supplies_transaction_id')
        .where("EXTRACT(MONTH from transaction_date) = ?",params[:m])
        .where("EXTRACT(YEAR from transaction_date) = ?",params[:y])
        .select('supplies_transaction_items.product_id as product_id,qty_in,products.name as product_name, qty_out, item_units.name as unit')
        .group('supplies_transaction_items.product_id, qty_in,qty_out, product_name, unit')    

      respond_to do |format|
        format.html
        format.pdf do
          render pdf:         "Supplies_Transactions_Recap_#{Date.current()}",
                 disposition: 'inline',
                 template:    'supplies_transactions/recap.pdf.slim',
                 layout:      'pdf.html',
                 show_as_html: params.key?('debug')
        end
      end     
    else
      redirect_to recap_supplies_transactions_url(m:Time.now.month,y:Time.now.year)
    end
  end

  private
    # Enable Sort column
    def sortable_columns 
      [:transaction_date, :name]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_supplies_transaction      
      @supplies_transaction = SuppliesTransaction.find(params[:id])      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplies_transaction_params
      params.require(:supplies_transaction).permit(:transaction_date, :employee_id, :card, :notes, :itemcount, 
                                                  {supplies_transaction_items_attributes: [:id, :supplies_transaction_id, :product_id, :in_out, :qty, :_destroy, :id]})
    end
end
