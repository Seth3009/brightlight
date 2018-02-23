class Supply < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category

  def self.disable_item(supply)
    self.find(supply).update(:supply_status => false)
  end

end
