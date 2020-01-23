class PurchaseReceivesController < ApplicationController
  before_action :set_purchase_receive, only: [:show, :edit, :update, :destroy]

  # GET /purchase_receives
  # GET /purchase_receives.json
  def index
    items_per_page = 30
    if current_user.can? :manage, PurchaseReceive
      @purchase_receives = PurchaseReceive.all.paginate(page: params[:page], per_page: items_per_page)
    else
      @purchase_receives = PurchaseReceive.for_requester(current_user.employee).paginate(page: params[:page], per_page: items_per_page)
    end
  end

  # GET /purchase_receives/1
  # GET /purchase_receives/1.json
  def show
    @po = @purchase_receive.purchase_order
    authorize! :read, @po
  end

  # GET /purchase_receives/new
  def new
    authorize! :create, PurchaseReceive
    
    if params[:po]
      @po = PurchaseOrder.find params[:po]
      @purchase_receive = PurchaseReceive.new_from_po @po
      if params[:items]
        order_items = OrderItem.where(id: params[:items].map(&:first))
        @receive_items = ReceiveItem.new_from_order_items(order_items) 
      elsif params[:rcvitems]
        @receive_items = ReceiveItem.new_from_other_items(params[:rcvitems].map &:first)
      else
        @receive_items = @purchase_receive.receive_items
      end
    else
      @purchase_receive = PurchaseReceive.new
    end
  end

  def check
    respond_to do |format|
      format.html
      format.js {
        @checker = Employee.with_badge_code(params[:code]).take
        if @checker
          @purchase_receives = PurchaseReceive.received.for_requester(@checker).order(updated_at: :desc, created_at: :desc)
          unless @purchase_receives.present?
            @errors = "No new purchase receipt found"
          end 
        else
          @errors = "Invalid badge"
        end
      }
    end
  end

  # GET /purchase_receives/1/edit
  def edit
    authorize! :update, @purchase_receive
    @receipt = @purchase_receive
    @po = @purchase_receive.purchase_order
    @checker_id = params[:checker]
    @checking = params[:check] == 'y' && @purchase_receive.status == 'Received'
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /purchase_receives
  # POST /purchase_receives.json
  def create
    authorize! :create, PurchaseReceive
    @purchase_receive = PurchaseReceive.new(purchase_receive_params)

    respond_to do |format|
      if @purchase_receive.save
        @purchase_receive.purchase_order.receive!
        @purchase_receive.notify_requesters { |req, po, purchase_receive| PurchaseReceiveEmailer.purchase_receive req, po, purchase_receive }
        format.html { redirect_to @purchase_receive, notice: 'Purchase receive was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_receive }
      else
        format.html { render :new }
        format.json { render json: @purchase_receive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_receives/1
  # PATCH/PUT /purchase_receives/1.json
  def update
    authorize! :update, @purchase_receive
    respond_to do |format|
      if @purchase_receive.update(purchase_receive_params)
        @purchase_receive.purchase_order.receive!
        format.html { redirect_to @purchase_receive, notice: 'Purchase receive was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_receive }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @purchase_receive.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /purchase_receives/1
  # DELETE /purchase_receives/1.json
  def destroy
    authorize! :destroy, @purchase_receive
    @purchase_receive.destroy
    respond_to do |format|
      format.html { redirect_to purchase_receives_url, notice: 'Purchase receive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_receive
      @purchase_receive = PurchaseReceive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_receive_params
      params.require(:purchase_receive).permit(:purchase_order_id, :date_received, :date_checked, :receiver_id, 
        :checker_id, :notes, :partial, :status,
        {:receive_items_attributes => [:quantity, :unit, :partial, :location, :code, :qty_accepted, :qty_rejected, 
         :receiver_id, :checker_id, :purchase_receive_id, :order_item_id, :notes, :_destroy, :id ]})
    end
end
