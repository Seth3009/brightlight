class PurchaseReceive < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :checker, class_name: 'Employee'

  has_many :receive_items, dependent: :destroy
  has_many :order_items, through: :receive_items

  accepts_nested_attributes_for :receive_items, reject_if: :all_blank, allow_destroy: true

  scope :for_requester, lambda {|requester| 
    joins(:purchase_order)
    .where('purchase_orders.requestor_id = ? OR receiver_id = ? OR checker_id = ?', requester.id, requester.id, requester.id)
  }

  def self.new_from_po(po)
    purchase_receive = PurchaseReceive.new 
    purchase_receive.purchase_order = po
    # purchase_receive.address = "#{po.dlvry_address} #{po.dlvry_address2}, #{po.dlvry_city} #{po.dlvry_post_code}"
    po.order_items.each do |item|
      purchase_receive.receive_items.build(
        order_item_id: item.id,
        quantity: item.quantity,
        unit: item.unit
      )
    end
    purchase_receive
  end

  def notify_requesters
    purchase_order.unique_requests.each do |req|
      email = yield req, purchase_order, self
      email.deliver_now
      Message.create_from_email(email)
    end
  end
end
