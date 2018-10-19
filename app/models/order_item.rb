class OrderItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :req_item
  belongs_to :stock_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items

  validates :req_item_id, presence: true

  after_save :sync_req_item

  private

    def sync_req_item
      self.req_item.order_item_id = self.id
    end
end
