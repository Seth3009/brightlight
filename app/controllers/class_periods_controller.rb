class ClassPeriodsController < ApplicationController
  before_action :set_class_period, only: [:show, :edit, :update, :destroy]

  # GET /class_periods
  # GET /class_periods.json
  def index
    @class_periods = ClassPeriod.all
  end

  # GET /class_periods/1
  # GET /class_periods/1.json
  def show
  end

  # GET /class_periods/new
  def new
    @class_period = ClassPeriod.new
  end

  # GET /class_periods/1/edit
  def edit
  end

  # POST /class_periods
  # POST /class_periods.json
  def create
    @class_period = ClassPeriod.new(class_period_params)

    respond_to do |format|
      if @class_period.save
        format.html { redirect_to @class_period, notice: 'Class period was successfully created.' }
        format.json { render :show, status: :created, location: @class_period }
      else
        format.html { render :new }
        format.json { render json: @class_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_periods/1
  # PATCH/PUT /class_periods/1.json
  def update
    respond_to do |format|
      if @class_period.update(class_period_params)
        format.html { redirect_to @class_period, notice: 'Class period was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_period }
      else
        format.html { render :edit }
        format.json { render json: @class_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_periods/1
  # DELETE /class_periods/1.json
  def destroy
    @class_period.destroy
    respond_to do |format|
      format.html { redirect_to class_periods_url, notice: 'Class period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_period
      @class_period = ClassPeriod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_period_params
      params.require(:class_period).permit(:name, :start_time, :end_time, :school, :is_break)
    end
end
