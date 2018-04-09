class SuppliesTransactionItemsController < ApplicationController
  before_action :set_supplies_transaction_item, only: [:show, :edit, :update, :destroy]

  # GET /supplies_transaction_items
  # GET /supplies_transaction_items.json
  def index
    authorize! :read, SuppliesTransactionItem
    @supplies_transaction_items = SuppliesTransactionItem.all
  end

  # GET /supplies_transaction_items/1
  # GET /supplies_transaction_items/1.json
  def show
  end

  # GET /supplies_transaction_items/new
  def new
    @supplies_transaction_item = SuppliesTransactionItem.new
  end

  # GET /supplies_transaction_items/1/edit
  def edit
  end

  # POST /supplies_transaction_items
  # POST /supplies_transaction_items.json
  def create
    authorize! :manage, SuppliesTransactionItem
    @supplies_transaction_item = SuppliesTransactionItem.new(supplies_transaction_item_params)

    respond_to do |format|
      if @supplies_transaction_item.save
        format.html { redirect_to @supplies_transaction_item, notice: 'Supplies transaction item was successfully created.' }
        format.json { render :show, status: :created, location: @supplies_transaction_item }
      else
        format.html { render :new }
        format.json { render json: @supplies_transaction_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies_transaction_items/1
  # PATCH/PUT /supplies_transaction_items/1.json
  def update
    authorize! :manage, SuppliesTransactionItem
    respond_to do |format|
      if @supplies_transaction_item.update(supplies_transaction_item_params)
        format.html { redirect_to @supplies_transaction_item, notice: 'Supplies transaction item was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplies_transaction_item }
      else
        format.html { render :edit }
        format.json { render json: @supplies_transaction_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies_transaction_items/1
  # DELETE /supplies_transaction_items/1.json
  def destroy    
    authorize! :manage, SuppliesTransactionItem
    if @supplies_transaction_item.present?      
      @supplies_transaction_item.destroy
      SuppliesTransaction.count_item(@supplies_transaction_item.supplies_transaction_id)   
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Supplies transaction item was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplies_transaction_item        
      @supplies_transaction_item = SuppliesTransactionItem.find(params[:id])     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplies_transaction_item_params
      params.require(:supplies_transaction_item).permit(:supplies_transaction_id, :product_id, :in_out, :qty, :barcode)
    end
end
