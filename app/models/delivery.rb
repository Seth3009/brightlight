class Delivery < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :accepted_by, class_name: 'Employee'
  belongs_to :checked_by, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items, dependent: :destroy
  has_many :order_items, through: :delivery_items

  accepts_nested_attributes_for :delivery_items, reject_if: :all_blank, allow_destroy: true

  def self.new_from_po(po)
    delivery = Delivery.new 
    delivery.purchase_order = po
    delivery.address = "#{po.dlvry_address} #{po.dlvry_address2}, #{po.dlvry_city} #{po.dlvry_post_code}"
    po.order_items.each do |item|
      delivery.delivery_items.build(
        order_item_id: item.id,
        quantity: item.quantity,
        unit: item.unit
      )
    end
    delivery
  end
end
