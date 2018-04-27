class SuppliesTransactionItem < ActiveRecord::Base
  belongs_to :supplies_transaction
  belongs_to :product
  validates_presence_of :product
  validates_presence_of :qty

  after_destroy :update_item_count_supplies_transaction

  def update_item_count_supplies_transaction        
    supplies_transaction.update_item_count
  end
  
end
