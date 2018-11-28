class DiknasReportConvertedsController < ApplicationController
  before_action :set_diknas_report_converted, only: [:show, :edit, :update, :destroy]

  # GET /diknas_report_converteds
  # GET /diknas_report_converteds.json
  def index
    @diknas_report_converteds = DiknasReportConverted.all
  end

  # GET /diknas_report_converteds/1
  # GET /diknas_report_converteds/1.json
  def show
  end

  # GET /diknas_report_converteds/new
  def new
    @diknas_report_converted = DiknasReportConverted.new
  end

  # GET /diknas_report_converteds/1/edit
  def edit
  end

  # POST /diknas_report_converteds
  # POST /diknas_report_converteds.json
  def create
    @diknas_report_converted = DiknasReportConverted.new(diknas_report_converted_params)

    respond_to do |format|
      if @diknas_report_converted.save
        format.html { redirect_to @diknas_report_converted, notice: 'Diknas report converted was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_report_converted }
      else
        format.html { render :new }
        format.json { render json: @diknas_report_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_report_converteds/1
  # PATCH/PUT /diknas_report_converteds/1.json
  def update
    respond_to do |format|
      if @diknas_report_converted.update(diknas_report_converted_params)
        format.html { redirect_to @diknas_report_converted, notice: 'Diknas report converted was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_report_converted }
      else
        format.html { render :edit }
        format.json { render json: @diknas_report_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_report_converteds/1
  # DELETE /diknas_report_converteds/1.json
  def destroy
    @diknas_report_converted.destroy
    respond_to do |format|
      format.html { redirect_to diknas_report_converteds_url, notice: 'Diknas report converted was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_report_converted
      @diknas_report_converted = DiknasReportConverted.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_report_converted_params
      params.require(:diknas_report_converted).permit(:student_id, :academic_year_id, :academic_term_id, :grade_level_id, :notes)
    end
end
