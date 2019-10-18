class DeliveryItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :order_item
  belongs_to :accepted_by, class_name: 'Employee'
  belongs_to :checked_by, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  def self.new_from_order_items(order_items)
    order_items.map {|order_item|
      new(quantity: order_item.quantity,
        unit: order_item.unit,
        order_item_id: order_item.id
      )
    }
  end
end
