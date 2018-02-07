class BudgetsController < ApplicationController
  before_action :set_budget, only: [:edit, :update, :destroy]

  # GET /budgets
  # GET /budgets.json
  def index
    @academic_year = params[:year].present? ? AcademicYear.find(params[:year]) : AcademicYear.current
    @department = params[:dept].present? ? Department.find_by_code(params[:dept]) : current_user.try(:employee).try(:department)
    @budgets = Budget.where(department: @department, academic_year: @academic_year)
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @budget = Budget.includes([:budget_items]).find(params[:id])
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /import
  def import
    uploaded_io = params[:filename] 
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_io.read)
      if uploaded_io.content_type =~ /office.xlsx/
        budget = Budget.import_xlsx(file)
        redirect_to budget, notice: "Import succeeded"
      else
        redirect_to budgets_path, alert: 'Import failed: selected file is not an Excel file'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      params.require(:budget).permit(:department_id, :grade_level_id, :grade_section_id, :budget_holder_id, :academic_year_id, :is_submitted, 
                                     :submit_date, :is_approved, :approved_date, :approver_id, :is_received, :receiver_id, :received_date, :total_amt, 
                                     :notes, :category, :type, :group, :version,
                                     {budget_items_attributes: [:id, :budget_id, :description, :account, :line, :notes, :academic_year_id, :month, :amount, 
                                                                :actual_amt, :is_completed, :type, :category, :group, :_destroy]
                                     })
    end
end
