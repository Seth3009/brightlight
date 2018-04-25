class ActivitySchedulesController < ApplicationController
  before_action :set_activity_schedule, only: [:show, :edit, :update, :destroy]

  # GET /activity_schedules
  # GET /activity_schedules.json
  def index
    @activity_schedules = ActivitySchedule.all
  end

  # GET /activity_schedules/1
  # GET /activity_schedules/1.json
  def show
    @student_activities = StudentActivity.includes(:student).where(activity_schedule:@activity_schedule).all
  end

  # GET /activity_schedules/new
  def new
    @activity_schedule = ActivitySchedule.new
  end

  # GET /activity_schedules/1/edit
  def edit
  end

  # POST /activity_schedules
  # POST /activity_schedules.json
  def create
    @activity_schedule = ActivitySchedule.new(activity_schedule_params)

    respond_to do |format|
      if @activity_schedule.save
        format.html { redirect_to @activity_schedule, notice: 'Activity schedule was successfully created.' }
        format.json { render :show, status: :created, location: @activity_schedule }
      else
        format.html { render :new }
        format.json { render json: @activity_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_schedules/1
  # PATCH/PUT /activity_schedules/1.json
  def update
    respond_to do |format|
      if @activity_schedule.update(activity_schedule_params)
        format.html { redirect_to @activity_schedule, notice: 'Activity schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_schedule }
      else
        format.html { render :edit }
        format.json { render json: @activity_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_schedules/1
  # DELETE /activity_schedules/1.json
  def destroy
    @activity_schedule.destroy
    respond_to do |format|
      format.html { redirect_to activity_schedules_url, notice: 'Activity schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_schedule
      @activity_schedule = ActivitySchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_schedule_params
      params.require(:activity_schedule).permit(:activity, :start_date, :end_date, :sun_start, :sun_end, :mon_start, :mon_end, :tue_start, :tue_end, :wed_start, :wed_end, :thu_start, :thu_end, :fri_start, :fri_end, :sat_start, :sat_end, :is_active)
    end
end
