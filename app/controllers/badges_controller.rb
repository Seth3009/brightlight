class BadgesController < ApplicationController

  def index
    authorize! :read, Student
    respond_to do |format|
    format.json {      
        @badges = Badge.order(:kind,:name)
    }
  end
  # GET /badges/new
  def new
    authorize! :create, Badge
    @badge = Badge.new
    if params[:employee_id]
      @employee_id = params[:employee_id]
      @kind = 'Employee'
    elsif params[:student_id]
      @student_id = params[:student_id]
      @kind = 'Student'
    end
    @name = params[:name]
  end

  # POST /badges
  # POST /badges.json
  def create
    authorize! :create, Badge
    @badge = Badge.new(badge_params)

    respond_to do |format|
      if @badge.save
        format.json { render json: {code: @badge.code, name: @badge.name, id: @badge.kind=="Student" ? @badge.student_id : @badge.employee_id} }
      else
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    authorize! :destroy, Badge
    @badge = Badge.find(params[:id])
    @badge.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_params
      params.require(:badge).permit(:code, :detail, :student_id, :employee_id, :kind, :name, :active)
    end
end
