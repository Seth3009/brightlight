class Requisition < ActiveRecord::Base
  belongs_to :department
  belongs_to :requester
  belongs_to :supervisor
  belongs_to :budget
  belongs_to :budget_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
end
