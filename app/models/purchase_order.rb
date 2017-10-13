class PurchaseOrder < ActiveRecord::Base
  belongs_to :department
  belongs_to :requestor, class_name: 'User'
  belongs_to :approver, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
end
