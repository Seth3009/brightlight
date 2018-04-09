class EmployeeSmartcardsController < ApplicationController
  before_action :set_employee_smartcard, only: [:show, :edit, :update, :destroy]

  # GET /employee_smartcards
  # GET /employee_smartcards.json
  def index
    @employee_smartcards = EmployeeSmartcard.all

  end

  # GET /employee_smartcards/1
  # GET /employee_smartcards/1.json
  def show
    if params[:card]
      @employee = Employee.joins(:employee_smartcard).where(employee_smartcards: {card: params[:id]}).take      
      respond_to do |format|
        if @employee
          format.html
          format.json 
        else
          format.html { not_found }
          format.json { render json: {errors:"Invalid Card"}, status: :unprocessable_entity }
        end
      end
    else
      set_employee
    end
  end

  # GET /employee_smartcards/new
  def new
    @employee_smartcard = EmployeeSmartcard.new
  end

  # GET /employee_smartcards/1/edit
  def edit
  end

  # POST /employee_smartcards
  # POST /employee_smartcards.json
  def create
    @employee_smartcard = EmployeeSmartcard.new(employee_smartcard_params)

    respond_to do |format|
      if @employee_smartcard.save
        format.html { redirect_to @employee_smartcard, notice: 'Employee smartcard was successfully created.' }
        format.json { render :show, status: :created, location: @employee_smartcard }
      else
        format.html { render :new }
        format.json { render json: @employee_smartcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_smartcards/1
  # PATCH/PUT /employee_smartcards/1.json
  def update
    respond_to do |format|
      if @employee_smartcard.update(employee_smartcard_params)
        format.html { redirect_to @employee_smartcard, notice: 'Employee smartcard was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_smartcard }
      else
        format.html { render :edit }
        format.json { render json: @employee_smartcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_smartcards/1
  # DELETE /employee_smartcards/1.json
  def destroy
    @employee_smartcard.destroy
    respond_to do |format|
      format.html { redirect_to employee_smartcards_url, notice: 'Employee smartcard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_smartcard
      #@employee_smartcard = EmployeeSmartcard.find(params[:id])
      @employee_smartcard = params[:card] ? EmployeeSmartcard.find_by(card:params[:id]) : EmployeeSmartcard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_smartcard_params
      params.require(:employee_smartcard).permit(:card, :employee_id)
    end
end
