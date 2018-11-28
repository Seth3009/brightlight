json.array!(@diknas_report_converteds) do |diknas_report_converted|
  json.extract! diknas_report_converted, :id, :student_id, :academic_year_id, :academic_term_id, :grade_level_id, :notes
  json.url diknas_report_converted_url(diknas_report_converted, format: :json)
end
