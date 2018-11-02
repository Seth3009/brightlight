class ReqItem < ActiveRecord::Base
  belongs_to :requisition
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :order_item

  validates :description, presence: true

end
