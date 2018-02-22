class Supply < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
end
