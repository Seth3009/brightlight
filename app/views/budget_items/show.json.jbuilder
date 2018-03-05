json.extract! @budget_item, :id, :budget_id, :description, :account, :line, :notes, :academic_year, :month, :amount, 
                            :actual_amt, :is_completed, :type, :category, :group, :created_by_id, :created_at, :updated_at
json.year budget_item.academic_year.name
