json.array!(@student_tardies) do |student_tardy|
  json.extract! student_tardy, :id, :student_id, :grade, :reason, :employee_id, :academic_year_id
  json.url student_tardy_url(student_tardy, format: :json)
end
