json.array!(@budgets) do |budget|
<<<<<<< HEAD
  json.extract! budget, :id, :department, :grade_level, :grade_section, :budget_holder, :academic_year, :is_submitted, :submit_date, :is_approved, :approved_date, :approver, :is_received, :receiver, :received_date, :total_amt, :notes,, :category,, :type,, :group,, :version,
=======
  json.extract! budget, :id, :department_id, :owner_id, :grade_level_id, :grade_section_id, :academic_year_id, :submitted, :submit_date, :approved, :apprv_date, :approver_id, :type, :category, :active, :notes
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  json.url budget_url(budget, format: :json)
end
