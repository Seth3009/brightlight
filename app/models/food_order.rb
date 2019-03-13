class FoodOrder < ActiveRecord::Base
  belongs_to :food_supplier
end
