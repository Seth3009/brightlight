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
      else
        @receive_items = @purchase_receive.receive_items
      end
    else
      @purchase_receive = PurchaseReceive.new
    end
  end

  # GET /purchase_receives/1/edit
  def edit
    @po = @purchase_receive.purchase_order
  end

  # POST /purchase_receives
  # POST /purchase_receives.json
  def create
    @purchase_receive = PurchaseReceive.new(purchase_receive_params)

    respond_to do |format|
      if @purchase_receive.save
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
    respond_to do |format|
      if @purchase_receive.update(purchase_receive_params)
        format.html { redirect_to @purchase_receive, notice: 'Purchase receive was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_receive }
      else
        format.html { render :edit }
        format.json { render json: @purchase_receive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_receives/1
  # DELETE /purchase_receives/1.json
  def destroy
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
        {:receive_items_attributes => [:quantity, :unit, :partial, :qty_accepted, :qty_rejected, :receiver_id, :checker_id, :purchase_receive_id, :order_item_id, :notes, :_destroy, :id ]})
    end
end
