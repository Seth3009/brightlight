class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :list, :edit, :update, :destroy, :letter, :print, :mark]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    authorize! :read, PurchaseOrder
    items_per_page = 20

    if can? :process, Requisition
      @purchase_orders = PurchaseOrder.all
    else
      @purchase_orders = PurchaseOrder.where(requestor: current_employee)
    end
    @purchase_orders = @purchase_orders.index_table
      .order("#{sort_column} #{sort_direction}")
      .paginate(page: params[:page], per_page: items_per_page)
  end

  # GET /purchase_orders/report
  # GET /purchase_orders/report.json
  def report
    authorize! :read, PurchaseOrder
    @start_date = Date.parse(params[:start_date]) rescue Date.today
    @end_date = Date.parse(params[:end_date]) rescue Date.today
    @supplier = params[:supplier]
    @account = params[:account]
    @item = params[:item]
    @items = OrderItem.po_records(
        date: @start_date..@end_date, 
        supplier: @supplier,
        account: @account,
        item: @item
      )
    
    @accounts =  Account.joins(:requisitions)
                  .joins('join req_items on requisitions.id = req_items.requisition_id')
                  .joins('join order_items on order_items.id = req_items.order_item_id')
                  .joins('join purchase_orders on purchase_orders.id = order_items.purchase_order_id')
                  .where(purchase_orders: {order_date: @start_date..@end_date})
                  .uniq
    @suppliers = Supplier.joins(:purchase_orders)
                  .where(purchase_orders: {order_date: @start_date..@end_date})

    @est_total = @items.sum :line_amount
    @act_total = @items.sum :actual_amt
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
        @purchase_order.notify_requesters { |req, po| 
          PurchaseOrderEmailer.notify_requesters req, po
        }
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
    if @supplier.blank?
      redirect_to @purchase_order, alert: 'Supplier info is missing'
    else
      letter_using_template
    end
  end

  def print
    authorize! :create, PurchaseOrder
    @purchase_order.order! unless @purchase_order.ordered?
    respond_to do |format|
      format.js { head :no_content }
    end
  end

  def mark
    authorize! :update, PurchaseOrder
    case params[:mark]
    when 'acknowledge'
      @purchase_order.acknowledge! if @purchase_order.ordered?
    end
    redirect_to @purchase_order
  end

  private
    def letter_html
    end

    def letter_using_template
      @template = Template.find_by(target:'po_letter', active:'true')

      if @template
        @template.placeholders = {
          order_date: @purchase_order.order_date.strftime("%d %B %Y"),
          order_num: @purchase_order.order_num,
          supplier_name: @purchase_order.supplier.company_name,
          supplier_address: @purchase_order.supplier.full_address,
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
          :discount, :est_tax, :non_recurring, :shipping, :actual_amt, :_destroy, :id ]})
    end

    def sortable_columns 
      [:id, :supplier_name, :requestor_name, :order_date, :order_status]
    end
end
