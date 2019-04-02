class ApproversController < ApplicationController
  before_action :set_approver, only: [:show, :edit, :update, :destroy]

  # GET /approvers
  # GET /approvers.json
  def index
    @approvers = Approver.with_names.order("#{sort_column} #{sort_direction}")   
    cat = params[:cat] || session[:cat]
    dept = params[:dept] || session[:dept]
    if cat.present? && cat != 'all'
      @approvers = @approvers.where(category: params[:cat]) 
      @category = params[:cat]     
    end
    if dept.present? && dept != 'all'
      @approvers = @approvers.where(department: params[:dept])
      @department = Department.find(params[:dept])
    end
    session[:dept] = nil if dept == 'all'
    session[:cat] = nil if cat == 'all'
  end

  # GET /approvers/1
  # GET /approvers/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /approvers/new
  def new
    @approver = Approver.new
  end

  # GET /approvers/1/edit
  def edit
  end

  # POST /approvers
  # POST /approvers.json
  def create
    @approver = Approver.new(approver_params)

    respond_to do |format|
      if @approver.save
        format.html { redirect_to approvers_url, notice: 'Approver was successfully created.' }
        format.json { render :show, status: :created, location: @approver }
      else
        format.html { render :new }
        format.json { render json: @approver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /approvers/1
  # PATCH/PUT /approvers/1.json
  def update
    respond_to do |format|
      if @approver.update(approver_params)
        format.html { redirect_to approvers_url, notice: 'Approver was successfully updated.' }
        format.json { render :show, status: :ok, location: @approver }
      else
        format.html { render :edit }
        format.json { render json: @approver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /approvers/1
  # DELETE /approvers/1.json
  def destroy
    @approver.destroy
    respond_to do |format|
      format.html { redirect_to approvers_url, notice: 'Approver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_approver
      @approver = Approver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def approver_params
      params.require(:approver).permit(:employee_id, :category, :department_id, :event_id, :start_date, :end_date, :level, :type, :notes, :active)
    end

    def sortable_columns 
      [:employee_name, :department_name, :category]
    end 
end
