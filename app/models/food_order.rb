class FoodOrder < ActiveRecord::Base
  belongs_to :food_supplier
  has_many :food_order_items, -> { order(:id) }, dependent: :destroy
  validate :has_at_least_one_food_order_item
  accepts_nested_attributes_for :food_order_items,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['food_package_id'].blank? || attributes['qty_order'].blank? }

  scope :filter_query, lambda { |m,y|
    where("EXTRACT(MONTH from date_order) = ?",m)
    .where("EXTRACT(YEAR from date_order) = ?",y)
  }

  private
    def has_at_least_one_food_order_item     
      errors.add :food_order, 'must have at least one food item' if food_order_items.empty?
    end
end
