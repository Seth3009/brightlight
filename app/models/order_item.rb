class OrderItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :stock_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items
end
