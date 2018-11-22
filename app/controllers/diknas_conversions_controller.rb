class DiknasConversionsController < ApplicationController
  before_action :set_diknas_conversion, only: [:show, :edit, :update, :destroy]

  # GET /diknas_conversions
  # GET /diknas_conversions.json
  def index
    @diknas_conversions = DiknasConversion.all
    # @course = params[:course].present? ? Course.find(params[:course]) : Course.current

  end

  # GET /diknas_conversions/1
  # GET /diknas_conversions/1.json
  def show
  end

  # GET /diknas_conversions/new
  def new
    @diknas_conversion = DiknasConversion.new
  end

  # GET /diknas_conversions/1/edit
  def edit
  end

  # POST /diknas_conversions
  # POST /diknas_conversions.json
  def create
    @diknas_conversion = DiknasConversion.new(diknas_conversion_params)

    respond_to do |format|
      if @diknas_conversion.save
        format.html { redirect_to @diknas_conversion, notice: 'Diknas conversion was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_conversion }
      else
        format.html { render :new }
        format.json { render json: @diknas_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_conversions/1
  # PATCH/PUT /diknas_conversions/1.json
  def update
    respond_to do |format|
      if @diknas_conversion.update(diknas_conversion_params)
        format.html { redirect_to @diknas_conversion, notice: 'Diknas conversion was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_conversion }
      else
        format.html { render :edit }
        format.json { render json: @diknas_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_conversions/1
  # DELETE /diknas_conversions/1.json
  def destroy
    @diknas_conversion.destroy
    respond_to do |format|
      format.html { redirect_to diknas_conversions_url, notice: 'Diknas conversion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_conversion
      @diknas_conversion = DiknasConversion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_conversion_params
      params.require(:diknas_conversion).permit(:course_id, :diknas_course_id, :diknas_academic_year_id, :diknas_academic_term_id, :academic_year_id, :academic_term_id, :weight, :notes)
    end
end
