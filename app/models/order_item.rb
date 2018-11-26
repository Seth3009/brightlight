class OrderItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :req_item
  belongs_to :stock_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items

  validates :req_item_id, presence: true
  validates_uniqueness_of :req_item_id, message: "Requested item has been ordered before."

  after_save :sync_req_item
  before_destroy :remove_link_with_req_item

  def self.new_from_req_items(req_items)
    req_items.map {|req_item|
      new(description: req_item.description,
        quantity: req_item.qty_reqd,
        unit: req_item.unit,
        unit_price: req_item.est_price,
        currency: req_item.currency,
        req_item_id: req_item.id
      )
    }
  end

  def requisition
    req_item.try(:requisition)
  end

  def requestor
    requisition.try(:requester)
  end

  private

    def sync_req_item
      req_item.update_columns order_item_id: self.id
      req_item.requisition.update_status
    end

    def remove_link_with_req_item
      req_item.update_columns order_item_id: nil
      req_item.requisition.update_status
    end

end
