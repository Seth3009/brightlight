class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    authorize! :read, PurchaseOrder
    @purchase_orders = PurchaseOrder.all.includes([:requestor, :supplier, :order_items])
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    authorize! :read, PurchaseOrder
  end

  def list
    authorize! :read, PurchaseOrder
    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i) rescue Date.today
    @purchase_orders = PurchaseOrder.where(order_date: date).includes([:requestor, :supplier, order_items: [:req_item]])
  end

  def status 
    authorize! :read, PurchaseOrder
    today = Date.today
    start_date = Date.new(params[:year].to_i, params[:month].to_i, 1) rescue Date.new(today.year, today.month, 1)
    end_date = Date.new(params[:year].to_i, params[:month].to_i, -1) rescue Date.new(today.year, today.month, -1)
    @purchase_orders = PurchaseOrder.where(order_date: start_date..end_date).includes([:requestor, :supplier, :order_items])
  end

  # GET /purchase_orders/new
  def new
    authorize! :create, PurchaseOrder
    if params[:req]
      req = Requisition.find params[:req]
      @purchase_order = PurchaseOrder.new_from_requisition req
      if params[:items]
        req_items = ReqItem.where(id: params[:items].map(&:first))
        @order_items = OrderItem.new_from_req_items(req_items) 
      else
        @order_items = @purchase_order.order_items
      end
    else
      @purchase_order = PurchaseOrder.new
    end
    @buyers = User.purchasing
  end

  # GET /purchase_orders/1/edit
  def edit
    authorize! :update, PurchaseOrder
    @buyers = User.purchasing
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    authorize! :create, PurchaseOrder
    @purchase_order = PurchaseOrder.new(purchase_order_params)

    respond_to do |format|
      if @purchase_order.save
        @purchase_order.notify_requesters
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { 
          @buyers = User.purchasing
          render :new 
        }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    authorize! :update, PurchaseOrder
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    authorize! :destroy, PurchaseOrder
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:order_num, :requestor_id, :order_date, :due_date, :total_amount, :requestor, :department_id, 
        :is_active, :currency, :deleted, :notes, :completed_date, :supplier_id, :contact, :phone_contact, :user_id, :status, :buyer_id, 
        :instructions, :subtotal, :discounts, :est_tax, :non_recurring, :shipping, :down_payment,
        {:order_items_attributes => [:stock_item__id, :quantity, :unit, :min_delivery_qty, :pending_qty, :type, :line_amount, 
          :unit_price, :currency, :deleted, :description, :status, :line_num, :extra1, :extra2, :req_item_id,
          :discount, :est_tax, :non_recurring, :shipping, :_destroy, :id ]})
    end
end
