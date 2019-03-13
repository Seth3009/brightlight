class FoodOrderItem < ActiveRecord::Base
  belongs_to :food_order
  belongs_to :food_package
end
