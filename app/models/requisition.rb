class Requisition < ActiveRecord::Base
  belongs_to :department
  belongs_to :requester
  belongs_to :supervisor
  belongs_to :budget
  belongs_to :budget_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  
  has_many :req_items
  accepts_nested_attributes_for :req_items, reject_if: :all_blank, allow_destroy: true
end