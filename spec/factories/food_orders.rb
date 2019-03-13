FactoryGirl.define do
  factory :food_order do
    date_order "2019-03-13"
    order_notes "MyString"
    food_supplier nil
    is_completed false
  end
end
