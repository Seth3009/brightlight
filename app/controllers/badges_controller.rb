class BadgesController < ApplicationController

  # GET /badges/new
  def new
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

  # GET /badges/1/edit
  def edit
  end

  # POST /badges
  # POST /badges.json
  def create
    @badge = Badge.new(badge_params)

    respond_to do |format|
      if @badge.save
        format.json { render json: {code: @badge.code, name: @badge.name, id: @badge.kind=="Student" ? @badge.student_id : @badge.employee_id} }
      else
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /badges/1
  # PATCH/PUT /badges/1.json
  def update
    respond_to do |format|
      if @badge.update(badge_params)
        format.html { redirect_to @badge, notice: 'Badge was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge }
      else
        format.html { render :edit }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    @badge.destroy
    respond_to do |format|
      format.html { redirect_to badges_url, notice: 'Badge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge
      @badge = Badge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_params
      params.require(:badge).permit(:code, :detail, :student_id, :employee_id, :kind, :name, :active)
    end
end
