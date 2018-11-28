class DiknasReportConvertedItemsController < ApplicationController
  before_action :set_diknas_report_converted_item, only: [:show, :edit, :update, :destroy]

  # GET /diknas_report_converted_items
  # GET /diknas_report_converted_items.json
  def index
    @diknas_report_converted_items = DiknasReportConvertedItem.all
  end

  # GET /diknas_report_converted_items/1
  # GET /diknas_report_converted_items/1.json
  def show
  end

  # GET /diknas_report_converted_items/new
  def new
    @diknas_report_converted_item = DiknasReportConvertedItem.new
  end

  # GET /diknas_report_converted_items/1/edit
  def edit
  end

  # POST /diknas_report_converted_items
  # POST /diknas_report_converted_items.json
  def create
    @diknas_report_converted_item = DiknasReportConvertedItem.new(diknas_report_converted_item_params)

    respond_to do |format|
      if @diknas_report_converted_item.save
        format.html { redirect_to @diknas_report_converted_item, notice: 'Diknas report converted item was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_report_converted_item }
      else
        format.html { render :new }
        format.json { render json: @diknas_report_converted_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_report_converted_items/1
  # PATCH/PUT /diknas_report_converted_items/1.json
  def update
    respond_to do |format|
      if @diknas_report_converted_item.update(diknas_report_converted_item_params)
        format.html { redirect_to @diknas_report_converted_item, notice: 'Diknas report converted item was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_report_converted_item }
      else
        format.html { render :edit }
        format.json { render json: @diknas_report_converted_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_report_converted_items/1
  # DELETE /diknas_report_converted_items/1.json
  def destroy
    @diknas_report_converted_item.destroy
    respond_to do |format|
      format.html { redirect_to diknas_report_converted_items_url, notice: 'Diknas report converted item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_report_converted_item
      @diknas_report_converted_item = DiknasReportConvertedItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_report_converted_item_params
      params.require(:diknas_report_converted_item).permit(:diknas_report_converted_id, :diknas_conversion_id, :P_score, :T_score, :comment)
    end
end
