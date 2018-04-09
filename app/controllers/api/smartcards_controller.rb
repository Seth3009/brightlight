class Api::SmartcardsController < Api::BaseController

  # GET /api/smartcards.json
  def index
    @smartcards = EmployeeSmartcard.all
    render json: @smartcards
  end

  # GET /api/smartcards/1.json
  def show
    @employee = Employee.joins(:employee_smartcard).where(employee_smartcards: {card: params[:id]}).take
    if @employee
      render json: @employee
    else
      render json: {errors:"Invalid Card"}, status: :unprocessable_entity
    end
  end
end