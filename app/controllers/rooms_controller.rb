class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :badges, :add_badges]
  before_action :sortable_columns, only: [:show]

  # GET /rooms
  # GET /rooms.json
  def index
    authorize! :read, Room
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    authorize! :read, Room
    @room_accesses = RoomAccess.with_student_and_current_grade_section
                      .where(room: @room)
                      .order("#{sort_column} #{sort_direction}")
  end

  # GET /rooms/new
  def new
    authorize! :create, Room
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    authorize! :update, Room
  end

  # POST /rooms
  # POST /rooms.json
  def create
    authorize! :create, Room
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_url, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    authorize! :update, Room
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_url, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    authorize! :destroy, Room
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end

  def badges
    @filterrific = initialize_filterrific(
      Badge.with_grade_section.order(:name),
      params[:filterrific],
      available_filters: [:search_query, :sorted_by, :by_kind, :by_grade_section],
      select_options: {
        filtered_by: Badge.options_for_sorted_by        
      }
    ) or return

    @badges = @filterrific.find.page(params[:page])

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

  def add_badges  
    authorize! :update, Room

    if params[:add].present?
      @room.room_accesses.create params[:add].map {|id, on| {badge_id: id}}
      redirect_to badges_room_url(@room), notice: 'Badge Card successfully added'
    else
      head :no_content
    end
  end

  def remove_badges
    authorize! :update, Room
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:room_code, :room_name, :location, :ip_address, :public_access,
                          {:room_accesses_attributes => [:id, :badge_id, :room_id, :_destroy]})
    end

    private
    def sortable_columns     
      [:name, :gs_name, :kind, :code ]
    end
end
