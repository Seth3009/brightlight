class Product < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
  validates_uniqueness_of :code
  validates_presence_of :code
  has_many :supplies_transaction_item

  def self.disable_item(product)
    self.find(product).update(:is_active => false)
  end
end
