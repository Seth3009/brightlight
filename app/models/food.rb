class Food < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :recipes
  has_many :raw_foods, through: :recipes

  accepts_nested_attributes_for :recipes, allow_destroy: true, reject_if: :all_blank
  
  after_save :ingredient_count
  def ingredient_count
    self.update_column :ingredients, recipes.count
  end

  def self.disable_item(food)
    if self.find(food).is_active?
      self.find(food).update(:is_active => false)
    else
      self.find(food).update(:is_active => true)
    end
  end
end
