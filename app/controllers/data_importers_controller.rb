class DataImportersController < ApplicationController
  def index
    authorize! :manage, Student
  end

  def student_composition
    authorize! :manage, Student
    uploaded_io = params[:filename] 
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_io.read)
      if uploaded_io.content_type =~ /office.xlsx/ || uploaded_io.content_type =~ /officedocument/
        importer = StudentCompositionImporter.new(params[:academic_year], file, params[:sheet_name])
        importer.import
        redirect_to data_importers_url, notice: "Import succeeded"
      else
        render :index, alert: 'Import failed: selected file is not an Excel file'
      end
    end
  end

  private 

  def path(filename)
    Rails.root.join('public', 'uploads', filename.original_filename)
  end
end
