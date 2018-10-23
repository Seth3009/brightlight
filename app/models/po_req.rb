class PoReq < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :requisition
  belongs_to :user
end
