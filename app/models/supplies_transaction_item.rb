class SuppliesTransactionItem < ActiveRecord::Base
  belongs_to :supplies_transaction
  belongs_to :product
  validates_presence_of :product
  validates_presence_of :qty
  
end
