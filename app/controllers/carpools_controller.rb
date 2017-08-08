class CarpoolsController < ApplicationController
  before_action :set_carpool, only: [:show, :update, :destroy]
  before_action :check_format, except: [:index, :reorder]
  # before_action :detect_device_format

  layout 'sans_sidebar'
  @@reorder = 0

  # GET /carpools
  # GET /carpools.json
  def index
    authorize! :read, Carpool
    @carpool = Carpool.new

    respond_to do |format|
      format.json
      format.html          # /app/views/carpools/index.html.slim
      # format.html.phone    # /app/views/carpools/index.html+phone.slim
      # format.html.tablet   # /app/views/carpools/index.html+tablet.slim
    end
  end

  # GET /carpools/poll
  def poll
    authorize! :read, Carpool
    @carpools = Carpool.all.order(:sort_order,:updated_at)
    now = Time.now
    if now < Carpool.end_of_morning_period
      @carpools = @carpools.today_am
    else
      @carpools = @carpools.today_pm
    end

    @timestamp = @carpools.present? ? (@carpools.last.updated_at.to_f*1000).to_i : nil
    @reorder = @@reorder
    
    if params[:since]      
      @carpools = @carpools.since params[:since] unless params[:since].to_i < @reorder
    end    
    respond_to :json
  end

  # GET /carpools/1
  # GET /carpools/1.json
  def show 
    authorize! :read, Carpool 
    @expected_passengers = @carpool.late_passengers.active if params[:lpax]
  end

  # GET /carpools/new
  def new
    authorize! :create, Carpool
    @carpool = Carpool.new
  end

  # GET /carpools/1/edit
  def edit
    authorize! :update, Carpool
    @carpool = Carpool.includes(:passengers).find(params[:id])
    @carpool.passengers.each do |pax|
      @carpool.late_passengers.build transport:pax.transport, student:pax.student,
              grade_section:pax.grade_section, name:pax.name, class_name:pax.class_name,
              family_no:pax.family_no, family_id:pax.family_id, active:false
    end if @carpool.late_passengers.empty?
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /carpools
  # POST /carpools.json
  def create
    authorize! :update, Carpool
    @carpool = Carpool.new(carpool_params)

    respond_to do |format|
      if @carpool.save
        format.html { redirect_to @carpool, notice: 'Carpool was successfully created.' }
        format.json { render :show, status: :created, location: @carpool }
      else
        format.html { render :new }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpools/1
  # PATCH/PUT /carpools/1.json
  def update
    authorize! :update, Carpool
    respond_to do |format|
      if @carpool.update(carpool_params) 
        format.html { redirect_to @carpool, notice: 'Carpool was successfully updated.' }
        format.json { render :show, status: :ok, location: @carpool }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpools/1
  # DELETE /carpools/1.json
  def destroy
    authorize! :destroy, Carpool
    @carpool.destroy
    respond_to do |format|
      format.html { redirect_to carpools_url, notice: 'Carpool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reorder
    authorize! :update, Carpool
    @carpools = Carpool.update(params[:carpools].keys, params[:carpools].values)
    @@reorder = (Time.now.to_f*1000).to_i
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpool
      if Time.now < Carpool.end_of_morning_period
        @carpool = Carpool.today_am.find_uid(params[:id])
      else
        @carpool = Carpool.today_pm.find_uid(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carpool_params
      params.require(:carpool).permit(:category, :transport_id, :barcode, :transport_name, :period, :sort_order,
                                      :active, :status, :arrival, :departure, :notes,
                                      late_passengers_attributes: [:id, :name, :student_id, :transport_id, :family_no,
                                        :family_id, :active, :grade_section_id, :class_name])
    end

    def check_format
      redirect_to carpools_path unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
    end

    def detect_device_format
      case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :phone
      when /Android/i && /mobile/i
        request.variant = :phone
      when /Android/i
        request.variant = :tablet
      when /Windows Phone/i
        request.variant = :phone
      end
    end

end
