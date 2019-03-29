json.array!(@class_budgets) do |class_budget|
  json.extract! class_budget, :id, :department_id, :grade_level_id, :grade_section_id, :holder_id, :academic_year, :month, :amount, :balance, :actual, :notes
  json.url class_budget_url(class_budget, format: :json)
end
