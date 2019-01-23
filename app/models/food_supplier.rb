class FoodSupplier < ActiveRecord::Base
  has_many :food_packages_food_suppliers


  def self.disable_supplier(food_supplier)
    if self.find(food_supplier).is_active?
      self.find(food_supplier).update(:is_active => false)
    else
      self.find(food_supplier).update(:is_active => true)
    end
  end
end
