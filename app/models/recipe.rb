class Recipe < ActiveRecord::Base
  belongs_to :food
  belongs_to :raw_food

  after_destroy :item_count_food_ingredient

  def item_count_food_ingredient        
    food.ingredient_count
  end
end
