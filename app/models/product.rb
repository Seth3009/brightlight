class Product < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
  validates_uniqueness_of :code
  validates_presence_of :code

  def self.disable_item(product)
    self.find(product).update(:is_active => false)
  end
end
