class DiknasGradebooksController < ApplicationController
  before_action :set_diknas_gradebook, only: [:show, :edit, :update, :destroy]

  # GET /diknas_gradebooks
  # GET /diknas_gradebooks.json
  def index
    @diknas_gradebooks = DiknasGradebook.all
  end

  # GET /diknas_gradebooks/1
  # GET /diknas_gradebooks/1.json
  def show
  end

  # GET /diknas_gradebooks/new
  def new
    @diknas_gradebook = DiknasGradebook.new
  end

  # GET /diknas_gradebooks/1/edit
  def edit
  end

  # POST /diknas_gradebooks
  # POST /diknas_gradebooks.json
  def create
    @diknas_gradebook = DiknasGradebook.new(diknas_gradebook_params)

    respond_to do |format|
      if @diknas_gradebook.save
        format.html { redirect_to @diknas_gradebook, notice: 'Diknas gradebook was successfully created.' }
        format.json { render :show, status: :created, location: @diknas_gradebook }
      else
        format.html { render :new }
        format.json { render json: @diknas_gradebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diknas_gradebooks/1
  # PATCH/PUT /diknas_gradebooks/1.json
  def update
    respond_to do |format|
      if @diknas_gradebook.update(diknas_gradebook_params)
        format.html { redirect_to @diknas_gradebook, notice: 'Diknas gradebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @diknas_gradebook }
      else
        format.html { render :edit }
        format.json { render json: @diknas_gradebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diknas_gradebooks/1
  # DELETE /diknas_gradebooks/1.json
  def destroy
    @diknas_gradebook.destroy
    respond_to do |format|
      format.html { redirect_to diknas_gradebooks_url, notice: 'Diknas gradebook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diknas_gradebook
      @diknas_gradebook = DiknasGradebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diknas_gradebook_params
      params.require(:diknas_gradebook).permit(:studentname, :grade, :class, :avg, :semester)
    end
end
