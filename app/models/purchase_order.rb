class PurchaseOrder < ActiveRecord::Base
  belongs_to :department
  belongs_to :requestor, class_name: 'Employee'
  belongs_to :approver, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :order_items
end
