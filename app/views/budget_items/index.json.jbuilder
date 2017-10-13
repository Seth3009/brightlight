json.array!(@budget_items) do |budget_item|
<<<<<<< HEAD
  json.extract! budget_item, :id, :budget, :description,, :account,, :line, :notes,, :academic_year, :month, :amount, :actual_amt, :is_completed, :type,, :category,, :group
=======
  json.extract! budget_item, :id, :budget_id, :description, :notes, :amount, :currency, :used_amount, :completed, :appvl_notes, :approved, :approver_id, :date_approved
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  json.url budget_item_url(budget_item, format: :json)
end
