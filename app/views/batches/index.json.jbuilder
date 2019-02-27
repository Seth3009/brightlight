json.array!(@batches) do |batch|
  json.extract! batch, :id, :name, :course_id, :course_section_id, :academic_year_id, :academic_term_id, :start_date, :end_date
  json.url batch_url(batch, format: :json)
end
