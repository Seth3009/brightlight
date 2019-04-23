class ClassBudgetsController < ApplicationController
  before_action :set_class_budget, only: [:show, :edit, :update, :destroy]

  # GET /class_budgets
  # GET /class_budgets.json
  def index
    @class_budgets = ClassBudget.all
  end

  # GET /class_budgets/1
  # GET /class_budgets/1.json
  def show
  end

  # GET /class_budgets/new
  def new
    @class_budget = ClassBudget.new
  end

  # GET /class_budgets/1/edit
  def edit
  end

  # POST /class_budgets
  # POST /class_budgets.json
  def create
    @class_budget = ClassBudget.new(class_budget_params)

    respond_to do |format|
      if @class_budget.save
        format.html { redirect_to @class_budget, notice: 'Class budget was successfully created.' }
        format.json { render :show, status: :created, location: @class_budget }
      else
        format.html { render :new }
        format.json { render json: @class_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_budgets/1
  # PATCH/PUT /class_budgets/1.json
  def update
    respond_to do |format|
      if @class_budget.update(class_budget_params)
        format.html { redirect_to @class_budget, notice: 'Class budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_budget }
      else
        format.html { render :edit }
        format.json { render json: @class_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_budgets/1
  # DELETE /class_budgets/1.json
  def destroy
    @class_budget.destroy
    respond_to do |format|
      format.html { redirect_to class_budgets_url, notice: 'Class budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_budget
      @class_budget = ClassBudget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_budget_params
      params.require(:class_budget).permit(:department_id, :grade_level_id, :grade_section_id, :holder_id, :academic_year, :month, :amount, :balance, :actual, :notes)
    end
end
