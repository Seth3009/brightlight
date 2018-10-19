class ReqItem < ActiveRecord::Base
  belongs_to :requisition
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :order_item

  validates :description, presence: true

  after_create :update_requisition_status

  private
    def update_requisition_status
      self.requisition.update :status, 'ALLORDERED' if all_items_ordered?
    end

    def all_items_ordered? 
      self.requisition.req_items.reduce(true) do |req_item, acc| 
        acc && req_item.order_item.present?
      end
    end
end
