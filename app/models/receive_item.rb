class ReceiveItem < ActiveRecord::Base
  belongs_to :purchase_receive
  belongs_to :order_item
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :checker, class_name: 'Employee'

  def self.new_from_order_items(order_items)
    order_items.map {|order_item|
      new(quantity: order_item.quantity,
        unit: order_item.unit,
        order_item_id: order_item.id,
        qty_accepted: 0,
        qty_rejected: 0
      )
    }
  end

  def self.new_from_other_items(id_list)
    where(id: id_list).map {|item|
      new(quantity: item.quantity - item.qty_accepted,
        unit: item.unit,
        order_item_id: item.order_item_id,
        purchase_receive_id: item.purchase_receive_id,
        partial: true,
        location: item.location,
        code: item.code
      )
    }
  end
end
