class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    authorize! :read, Department
    @departments = Department.all.order(:name)
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    authorize! :read, Department
    @manager = @department.manager
    @members = @department.employees
  end

  # GET /departments/new
  def new
    authorize! :create, Department
    @department = Department.new
    @employees = Employee.all
  end

  # GET /departments/1/edit
  def edit
    authorize! :update, Department
    @employees = Employee.all
  end

  # POST /departments
  # POST /departments.json
  def create
    authorize! :create, Department
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
        format.js
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    authorize! :update, Department
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    authorize! :destroy, Department
    respond_to do |format|
      if @department.destroy
        format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
        format.json { head :no_content }
        format.js { head :no_content }
      else 
        format.html { redirect_to departments_url, alert: @department.errors.full_messages.join('. ') }
        format.json { render json: @department.errors, status: :unprocessable_entity }
        format.js { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :code, :manager_id, :vice_manager_id)
    end
end
