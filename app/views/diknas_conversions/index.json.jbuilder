json.array!(@diknas_conversions) do |diknas_conversion|
  json.extract! diknas_conversion, :id, :course_id, :diknas_course_id, :academic_year_id, :academic_term_id, :weight, :notes, :diknas_academic_year, :diknas_academic_term
  json.url diknas_conversion_url(diknas_conversion, format: :json)
end
