class FoodPackagesFoodSupplier < ActiveRecord::Base
  belongs_to :food_package
  belongs_to :food_supplier
end
