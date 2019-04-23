class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :destroy]

  def edit
    @date = Date.parse(params[:date]) rescue nil
    @supplier = params[:supplier]
    @account = params[:account]
    @item = params[:item]
    respond_to do |format|
      format.js
    end
  end
  
  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    respond_to do |format|
      @order_item = OrderItem.with_po_records.where(id: params[:id]).take
      @date = Date.parse(params[:date]) rescue nil
      @supplier = params[:supplier]
      @account = params[:account]
      @item = params[:item]
      @all_items = OrderItem.po_records(
        date: @date, 
        supplier: @supplier,
        account: @account,
        item: @item
      )
      if @order_item.update(order_item_params)
        @order_item.purchase_order.order! unless @order_item.purchase_order.ordered?
        @est_total = @all_items.sum :line_amount
        @act_total = @all_items.sum :actual_amt
        format.js 
      else
        format.js
      end
    end
  end
  
  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:purchase_order_id, :stock_item__id, :quantity, :unit, 
        :min_delivery_qty, :pending_qty, :type, :line_amount, :unit_price, :currency, :deleted, :description, 
        :status, :line_num, :actual_amt,
        :discount, :est_tax, :non_recurring, :shipping, :down_payment)
    end
end
