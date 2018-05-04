class ActivitySchedulesController < ApplicationController
  before_action :set_activity_schedule, only: [:show, :edit, :update, :destroy, :add_students, :students]
  before_action :set_year, only: [:students, :add_students, :show, :index, :new]

  # GET /activity_schedules
  # GET /activity_schedules.json
  def index
    authorize! :read, ActivitySchedule    
    @disable_edit = @year_id.to_i != AcademicYear.current_id 
    respond_to do |format|
      format.html {
        items_per_page = 20   
        @activity_schedules = ActivitySchedule.where(academic_year_id:@year_id).all
                              .paginate(page: params[:page], per_page: items_per_page)
      }
    end
  end

  # GET /activity_schedules/1
  # GET /activity_schedules/1.json
  def show                          
    @students = StudentActivity.where(academic_year:@year_id,activity_schedule:@activity_schedule)    
    @grade_sections = GradeSectionsStudent.joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
                      .select('student_id','grade_sections.name as name')
                      .where(academic_year_id:@year_id)
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

  def students   
    # @student_activities = StudentActivity.student_query                         
    #                      .where(activity_schedule_id:@activity_schedule)
    #                      .where('grade_sections_students.academic_year_id = ?', @year_id)
    @grade_sections = GradeSection.all
         
    @filterrific = initialize_filterrific(
      Student.current.order(:name),
      params[:filterrific],
      select_options: {
        filtered_by: Student.options_for_sorted_by        
      }
    ) or return

    @students = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def add_students    
    academic_year_id = params[:year]
    params[:add].map {|id,on| Student.find(id)}.each do |student|
      @sa = StudentActivity.new(student_id:student.id, activity_schedule_id:@activity_schedule.id, academic_year_id:@year_id)
      if @sa.save
        next
      else
        #render :students
        redirect_to students_activity_schedule_url, alert: 'Students already added' and return
      end
    end
    redirect_to activity_schedule_path(@activity_schedule, year:params[:year]), notice: 'Students successfully added'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_schedule
      @activity_schedule = ActivitySchedule.find(params[:id])
    end

    def set_year
      @year_id = params[:year] || AcademicYear.current_id
      @academic_year = AcademicYear.find(@year_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_schedule_params
      params.require(:activity_schedule).permit(:activity, :start_date, :end_date, :sun_start, :sun_end, :mon_start, :mon_end, :tue_start, :tue_end, :wed_start, :wed_end, :thu_start, :thu_end, :fri_start, :fri_end, :sat_start, :sat_end, :is_active, :academic_year_id,
                                                {:student_activities_attributes => [:id, :student_id, :activity_schedule_id, :_destroy]})
    end
end
