class SuppliesTransactionsController < ApplicationController
  before_action :set_supplies_transaction, only: [:show, :edit, :update, :destroy]
  after_action :set_count, only: [:create, :update]
  # GET /supplies_transactions
  # GET /supplies_transactions.json
  def index
    @supplies_transactions = SuppliesTransaction.all
  end

  # GET /supplies_transactions/1
  # GET /supplies_transactions/1.json
  def show
    @supplies_transaction_item = SuppliesTransactionItem.where(supplies_transaction_id: @supplies_transaction).all
  end

  # GET /supplies_transactions/new
  def new
    @supplies_transaction = SuppliesTransaction.new
  end

  # GET /supplies_transactions/1/edit
  def edit
  end

  # POST /supplies_transactions
  # POST /supplies_transactions.json
  def create
    @supplies_transaction = SuppliesTransaction.new(supplies_transaction_params)

    respond_to do |format|
      if @supplies_transaction.save
        format.html { redirect_to supplies_transactions_url, notice: 'Supplies transaction was successfully created.' }
        format.json { render :show, status: :created, location: @supplies_transaction }
      else
        format.html { render :new }
        format.json { render json: @supplies_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies_transactions/1
  # PATCH/PUT /supplies_transactions/1.json
  def update
    respond_to do |format|
      if @supplies_transaction.update(supplies_transaction_params)
        format.html { redirect_to supplies_transactions_url, notice: 'Supplies transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplies_transaction }
      else
        format.html { render :edit }
        format.json { render json: @supplies_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies_transactions/1
  # DELETE /supplies_transactions/1.json
  def destroy
    @supplies_transaction.destroy
    respond_to do |format|
      format.html { redirect_to supplies_transactions_url, notice: 'Supplies transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_count
      SuppliesTransaction.count_item(@supplies_transaction.id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_supplies_transaction
      @supplies_transaction = SuppliesTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplies_transaction_params
      params.require(:supplies_transaction).permit(:transaction_date, :employee_id, :itemcount,
                                                  {supplies_transaction_items_attributes: [:id, :supplies_transaction_id, :product_id, :in_out, :qty, :_destroy, :id]})
    end
end
