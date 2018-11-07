class DiknasreportsController < ApplicationController

    def index
        authorize! :read, Budget
        @academic_year = params[:year].present? ? AcademicYear.find(params[:year]) : AcademicYear.current
        @department = params[:dept].present? ? Department.find_by_code(params[:dept]) : current_user.try(:employee).try(:department)
        @budgets = Budget.where(department: @department, academic_year: @academic_year)
    end

     # POST /import
  def import
    authorize! :create, Budget
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
end