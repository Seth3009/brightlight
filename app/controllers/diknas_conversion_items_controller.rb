class DiknasConversionItemsController < ApplicationController
  before_action :set_diknas_conversion_item, only: [:show, :edit, :update, :destroy]

  # GET /diknas_conversion_items
  # GET /diknas_conversion_items.json
  def index
    @diknas_conversion_items = DiknasConversionItem.all
  end

  # GET /diknas_conversion_items/1
  # GET /diknas_conversion_items/1.json
  def show
  end

  # GET /diknas_conversion_items/new
  def new
    @diknas_conversion_item = DiknasConversionItem.new
  end

  # GET /diknas_conversion_items/1/edit
  def edit
  end

  # POST /diknas_conversion_items
  # POST /diknas_conversion_items.json
  def create
    @diknas_conversion_item = DiknasConversionItem.new(diknas_conversion_item_params)

    respond_to do |format|
      if @diknas_conversion_item.save
        format.html { redirect_to @diknas_conversion_item, notice: 'Diknas conversion item was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_conversion_item }
      else
        format.html { render :new }
        format.json { render json: @diknas_conversion_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_conversion_items/1
  # PATCH/PUT /diknas_conversion_items/1.json
  def update
    respond_to do |format|
      if @diknas_conversion_item.update(diknas_conversion_item_params)
        format.html { redirect_to @diknas_conversion_item, notice: 'Diknas conversion item was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_conversion_item }
      else
        format.html { render :edit }
        format.json { render json: @diknas_conversion_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_conversion_items/1
  # DELETE /diknas_conversion_items/1.json
  def destroy
    @diknas_conversion_item.destroy
    respond_to do |format|
      format.html { redirect_to diknas_conversion_items_url, notice: 'Diknas conversion item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_conversion_item
      @diknas_conversion_item = DiknasConversionItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_conversion_item_params
      params.require(:diknas_conversion_item).permit(:diknas_conversion_id, :course_id, :academic_year_id, :academic_term_id, :weight, :notes)
    end
end
