class ReceiveItem < ActiveRecord::Base
  belongs_to :purchase_receive
  belongs_to :order_item
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :checker, class_name: 'Employee'

  validates :qty_accepted, presence: true

  def self.new_from_order_items(order_items)
    order_items.map {|order_item|
      new(quantity: order_item.quantity,
        unit: order_item.unit,
        order_item_id: order_item.id,
        qty_accepted: order_item.quantity,
        qty_rejected: 0
      )
    }
  end
end
