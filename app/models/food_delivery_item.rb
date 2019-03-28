class FoodDeliveryItem < ActiveRecord::Base
  belongs_to :food_delivery
  belongs_to :food_package
end
