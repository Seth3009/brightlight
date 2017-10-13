class DeliveryItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :order_item
  belongs_to :accepted_by, class_name: 'User'
  belongs_to :checked_by, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
end
