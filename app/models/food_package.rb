class FoodPackage < ActiveRecord::Base  
  validates_presence_of :packaging, :message => "Packaging can't be blank"
  validates_presence_of :package_contents, :message => "Amount of content can't be blank"
  validates_presence_of :unit, :message => "Unit can't be blank"
  
  belongs_to :raw_food 
  after_save :update_stock

  def update_stock
    raw_food.total_stock
  end    

  def self.disable_item(food_package)
    if self.find(food_package).is_active?
      self.find(food_package).update(:is_active => false)
    else
      self.find(food_package).update(:is_active => true)
    end
  end
end
