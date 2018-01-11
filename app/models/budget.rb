class Budget < ActiveRecord::Base
  belongs_to :department
  belongs_to :budget_holder, class_name: 'User'
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :approver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
end
