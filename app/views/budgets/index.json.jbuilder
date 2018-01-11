json.array!(@budgets) do |budget|
  json.extract! budget, :id, :department_id, :grade_level_id, :grade_section_id, :budget_holder_id, :academic_year_id, :is_submitted, :submit_date, :is_approved, :approved_date, :approver_id, :is_received, :receiver_id, :received_date, :total_amt, :notes, :category, :type, :group, :version
  json.url budget_url(budget, format: :json)
end
