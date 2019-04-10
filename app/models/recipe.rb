class Recipe < ActiveRecord::Base
  belongs_to :food
  belongs_to :raw_food
  validates_presence_of :raw_food, :message => "Invalid Data"

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

  def current_qty(g1,g2,sol,sor,adult)
    if self.portion_size != 0
      self.portion_size * ((self.gr1_portion * g1) + (self.gr2_portion * g2) + (self.sol_portion * sol) + (self.sor_portion * sor) + (self.adult_portion * adult))
    else
      (self.qty/self.recipe_portion) * (g1 + g2 + sol + sor + adult)
    end
  end
end
