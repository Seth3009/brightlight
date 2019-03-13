FactoryGirl.define do
  factory :food_order_item do
    food_order nil
    food_package nil
    qty_order 1.5
    qty_received 1.5
  end
end
