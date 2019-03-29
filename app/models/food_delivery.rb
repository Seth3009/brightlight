class FoodDelivery < ActiveRecord::Base
  has_many :food_delivery_items,  dependent: :destroy
  validate :has_at_least_one_food_item

  accepts_nested_attributes_for :food_delivery_items,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['food_package_id'].blank? || attributes['qty'].blank? }

  scope :filter_query, lambda { |m,y|
    where("EXTRACT(MONTH from delivery_date) = ?",m)
    .where("EXTRACT(YEAR from delivery_date) = ?",y)
  }

  private
    def has_at_least_one_food_item     
      errors.add :food_delivery, 'must have at least one food item' if food_delivery_items.empty?
    end
end
