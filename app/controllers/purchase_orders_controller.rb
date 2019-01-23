class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :list, :edit, :update, :destroy, :letter]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    authorize! :read, PurchaseOrder
    @purchase_orders = PurchaseOrder.all.includes([:requestor, :supplier, :order_items])
  end

  # GET /purchase_orders/report
  # GET /purchase_orders/report.json
  def report
    authorize! :read, PurchaseOrder
    date = Date.parse(params[:date]) rescue Date.today

    @items = OrderItem.joins(:purchase_order)
              .joins('left join employees on employees.id = purchase_orders.requestor_id')
              .joins('left join suppliers on suppliers.id = purchase_orders.supplier_id')
              .joins(:req_item)
              .joins('left join requisitions on requisitions.id = req_items.requisition_id')
              .joins('left join accounts on accounts.id = requisitions.account_id')
              .where(purchase_orders: {order_date: date})
              .select('order_items.*, purchase_orders.currency as currency, requisitions.id as fpb, employees.name as requestor_name, accounts.description as budget, suppliers.company_name as supplier')

    if params[:supplier].present?
      @items = @items.where(purchase_orders: {supplier_id: params[:supplier]})
    end
    
    if params[:account].present?
      @items = @items.joins(:req_item)
                .where(accounts: {id: params[:account]})
    end

    if params[:item].present?
      @items = @items.where(description: params[:item])
    end
    
    @accounts =  Account.joins(:requisitions)
                  .joins('join req_items on requisitions.id = req_items.requisition_id')
                  .joins('join order_items on order_items.id = req_items.order_item_id')
                  .joins('join purchase_orders on purchase_orders.id = order_items.purchase_order_id')
                  .where(purchase_orders: {order_date: date})
                  .uniq
    @suppliers = Supplier.joins(:purchase_orders)
                  .where(purchase_orders: {order_date: date})
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    authorize! :read, PurchaseOrder
  end

    # GET /purchase_orders/1/list
  # GET /purchase_orders/1/list.json
  def list 
    authorize! :read, PurchaseOrder
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
        format.html { 
          if params[:req]
            requisition = Requisition.find params[:req] 
            if requisition.all_items_ordered?
              redirect_to @purchase_order, notice: 'Purchase order was successfully created.' 
            else
              redirect_to requisition, notice: 'Purchase order was successfully created.' 
            end
          else
            redirect_to @purchase_order, notice: 'Purchase order was successfully created.' 
          end
        }
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

  def letter
    authorize! :create, PurchaseOrder
    @supplier = @purchase_order.supplier
    if params[:template].present?
      letter_using_template(params[:template])
    else
      letter_html
    end
  end

  private
    def letter_html
    end

    def letter_using_template(template_name)
      @template = Template.find template_name
      @template = Template.where(target:'purchase_order_letter').where(active:'true').take unless @template

      if @template
        @template.placeholders = {
          order_date: @purchase_order.order_date,
          order_num: @purchase_order.order_num,
          supplier_name: @purchase_order.supplier.company_name,
          supplier_address: @purchase_order.full_address,
          supplier_phone: @purchase_order.supplier.phone,
          supplier_fax: @purchase_order.supplier.fax,
          supplier_contact: @purchase_order.supplier.contact_name,
          supplier_contact: @purchase_order.supplier.contact_name,
          supplier_bank: @purchase_order.supplier.bank,
          supplier_bank_branch: @purchase_order.supplier.bank_branch,
          supplier_bank_acct_no: @purchase_order.supplier.bank_acct_no,
          supplier_bank_acct_name: @purchase_order.supplier.bank_acct_name
        }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:order_num, :requestor_id, :order_date, :due_date, :total_amount, :requestor, :department_id, 
        :is_active, :currency, :deleted, :notes, :completed_date, :supplier_id, :contact, :phone_contact, :user_id, :status, :buyer_id, 
        :instructions, :subtotal, :discounts, :est_tax, :non_recurring, :shipping, :down_payment, :description,
        {:order_items_attributes => [:stock_item__id, :quantity, :unit, :min_delivery_qty, :pending_qty, :type, :line_amount, 
          :unit_price, :currency, :deleted, :description, :status, :line_num, :extra1, :extra2, :req_item_id, :remark,
          :discount, :est_tax, :non_recurring, :shipping, :_destroy, :id ]})
    end
end
