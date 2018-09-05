class Delivery < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :accepted_by, class_name: 'Employee'
  belongs_to :checked_by, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items
end
