class FoodOrderItem < ActiveRecord::Base
  belongs_to :food_order
  belongs_to :food_package
  after_save :update_qty, :update_stock
  after_destroy :update_qty, :update_stock
  
  def update_qty
    food_package.update_qty    
  end

  def update_stock
    food_package.update_stock
  end
  
end
