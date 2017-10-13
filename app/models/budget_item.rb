class BudgetItem < ActiveRecord::Base
  belongs_to :budget
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
end
