class Recipe < ActiveRecord::Base
  belongs_to :food
  belongs_to :raw_food

  after_destroy :item_count_food_ingredient
  after_save :item_count_food_ingredient
  after_save :portion_per_slice

  def item_count_food_ingredient        
    food.ingredient_count
  end

  def portion_per_slice
    if self.custom_size > 0
      if self.size_divider > 0
        self.update_column :portion_size, (self.custom_size/self.size_divider)
      else
        self.update_column :portion_size, self.custom_size
      end
    end
  end
end
