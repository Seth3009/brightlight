class DiknasConvertedsController < ApplicationController
  before_action :set_diknas_converted, only: [:show, :edit, :update, :destroy]

  # GET /diknas_converteds
  # GET /diknas_converteds.json
  def index
    @diknas_converteds = DiknasConverted.all
    # authorize! :read, DiknasConverted    
    # respond_to do |format|
    #   format.html {
    #     items_per_page = 10  
    #     @diknas_converteds = DiknasReportCard.select(:student_id).group(:student_id)
    #     # @diknas_converted = DiknasConvertedItem.joins('left join diknas_converteds on diknas_converteds.id = diknas_converted_items.diknas_converted_id')                                          
    #                             # .paginate(page: params[:page], per_page: items_per_page)
    #   }
    # end
  end

  # GET /diknas_converteds/1
  # GET /diknas_converteds/1.json
  def show
  end

  # GET /diknas_converteds/new
  def new
    @diknas_converted = DiknasConverted.new
  end

  # GET /diknas_converteds/1/edit
  def edit
  end

  # POST /diknas_converteds
  # POST /diknas_converteds.json
  def create
    @diknas_converted = DiknasConverted.new(diknas_converted_params)

    respond_to do |format|
      if @diknas_converted.save
        format.html { redirect_to @diknas_converted, notice: 'Diknas converted was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_converted }
      else
        format.html { render :new }
        format.json { render json: @diknas_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_converteds/1
  # PATCH/PUT /diknas_converteds/1.json
  def update
    respond_to do |format|
      if @diknas_converted.update(diknas_converted_params)
        format.html { redirect_to @diknas_converted, notice: 'Diknas converted was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_converted }
      else
        format.html { render :edit }
        format.json { render json: @diknas_converted.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_converteds/1
  # DELETE /diknas_converteds/1.json
  def destroy
    @diknas_converted.destroy
    respond_to do |format|
      format.html { redirect_to diknas_converteds_url, notice: 'Diknas converted was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_converted
      @diknas_converted = DiknasConverted.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_converted_params
      params.require(:diknas_converted).permit(:student_id, :academic_year_id, :academic_term_id, :grade_level_id, :notes, diknas_converted_items_attributes[:id, :diknas_conversion_id, :p_score, :t_score])
    end
end
