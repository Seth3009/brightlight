class FoodPackagesFoodSupplier < ActiveRecord::Base
  belongs_to :food_package
  belongs_to :food_supplier
  validates_presence_of :food_package, :message => "Invalid Data"


  def self.lowest_price(food_package_id)
    self.where(food_package_id: food_package_id).order(:price).first
  end
end
