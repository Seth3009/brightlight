json.array!(@budget_items) do |budget_item|
  json.extract! budget_item, :id, :budget_id, :description, :account, :line, :notes, :academic_year_id, :month, :amount, 
                :actual_amt, :is_completed, :type, :category, :group, :created_by_id
  json.year budget_item.academic_year.name
  json.department budget_item.budget.department
  json.url budget_item_url(budget_item, format: :json)
end
