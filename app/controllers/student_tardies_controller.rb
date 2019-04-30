class StudentTardiesController < ApplicationController
  before_action :set_student_tardy, only: [:show, :edit, :update, :destroy]

  # GET /student_tardies
  # GET /student_tardies.json
  def index
    @student_tardies = StudentTardy.where(date_tardy:(params[:fd] || Date.today)..(params[:td] || Date.today))
  end

  # GET /student_tardies/1
  # GET /student_tardies/1.json
  def show
  end

  # GET /student_tardies/new
  def new
    
    @student_tardy = StudentTardy.new
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @grade = @student.current_grade_section
      @homeroom = Employee.find(@grade.homeroom_id)
    end
    
  end

  # GET /student_tardies/1/edit
  def edit
  end

  # POST /student_tardies
  # POST /student_tardies.json
  def create
    @student_tardy = StudentTardy.new(student_tardy_params)

    respond_to do |format|
      if @student_tardy.save
        format.html { redirect_to :nothing, notice: 'Student tardy was successfully created.' }
        format.json { render :show, status: :created, location: @student_tardy }
        format.js 
      else
        format.html { render :new }
        format.json { render json: @student_tardy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_tardies/1
  # PATCH/PUT /student_tardies/1.json
  def update
    respond_to do |format|
      if @student_tardy.update(student_tardy_params)
        format.html { redirect_to @student_tardy, notice: 'Student tardy was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_tardy }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @student_tardy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_tardies/1
  # DELETE /student_tardies/1.json
  def destroy
    @student_tardy.destroy
    respond_to do |format|
      format.html { redirect_to student_tardies_url, notice: 'Student tardy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_tardy
      @student_tardy = StudentTardy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_tardy_params
      params.require(:student_tardy).permit(:student_id, :grade, :reason, :employee_id, :academic_year_id, :date_tardy, :grade_section_id)
    end
end
