class FoodSupplier < ActiveRecord::Base
  has_many :food_packages_food_suppliers
end
