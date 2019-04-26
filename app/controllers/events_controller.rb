class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    authorize! :read, Event
    @events = params[:v] == 'all' ? Event.all : Event.all.active
    year_id = params[:year] || AcademicYear.current_id
    @events = @events.where(academic_year_id: year_id)
    if params[:dept].present?
      @events = @events.where(department_id: dept_id) 
      @department = Department.find(params[:dept])
    end
    @academic_year = AcademicYear.find year_id
  end

  # GET /events/new
  def new
    authorize! :create, Event
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    authorize! :update, Event
  end

  # POST /events
  # POST /events.json
  def create
    authorize! :create, Event
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize! :update, Event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_url, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize! :destroy, Event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /events/submit
  def submit
    authorize! :update, Event
    @events = Event.where(id: params[:event].keys)
    @events.each { |event| event.submit! }
    Event.notify_approvers params[:event].keys
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Events submitted for approval.' }
    end
  end

  # GET /events/approve
  def approve
    authorize! :update, Event
    @events = Event.joins(approvals: :approver)
              .where('approvers.employee_id = ?', current_user.employee.try(:id))
              .where("aasm_state != 'approved'")
  end

  # POST /events/update_approval
  def update_approval
    authorize! :update, Event
    @events = Event.where(id: params[:event].keys)
    @events.each { |event| event.approve! }
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Events successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :department_id, :description, :manager_id, :start_date, :end_date,
          {approvers_attributes: [:id, :employee_id, :event_id, :department_id, :category, :type, :level, :start_date, :end_date, :notes, :active]}
        )
    end
end
