json.array!(@diknas_conversion_items) do |diknas_conversion_item|
  json.extract! diknas_conversion_item, :id, :diknas_conversion_id, :course_id, :academic_year_id, :academic_term_id, :weight, :notes
  json.url diknas_conversion_item_url(diknas_conversion_item, format: :json)
end
