class ReqItem < ActiveRecord::Base
  belongs_to :requisition
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :order_item

  validates :description, presence: true

  scope :incomplete, lambda { where(order_item:nil).order(:created_at).includes([requisition: :requester]) }

  def description_for_select
    "#{description} | FPB##{requisition_id} (#{requisition.requester.name})"
  end

  def self.incomplete_options_for_select
    ReqItem.incomplete.map do |item|
      [item.description_for_select, item.description, {data: {id: item.id, quantity: item.qty_reqd, unit: item.unit, unit_price: item.est_price, currency: item.currency }}]
    end
  end
end
