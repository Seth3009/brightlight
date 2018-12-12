json.array!(@diknas_converteds) do |diknas_converted|
  json.extract! diknas_converted, :id, :student_id, :academic_year_id, :academic_term_id, :grade_level_id, :notes
  json.url diknas_converted_url(diknas_converted, format: :json)
end
