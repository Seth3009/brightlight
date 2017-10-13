json.array!(@budget_items) do |budget_item|
  json.extract! budget_item, :id, :budget, :description,, :account,, :line, :notes,, :academic_year, :month, :amount, :actual_amt, :is_completed, :type,, :category,, :group
  json.url budget_item_url(budget_item, format: :json)
end
