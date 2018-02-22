FactoryGirl.define do
  factory :supply do
    code "MyString"
    name "MyString"
    price "9.99"
    min_stock 1.5
    max_stock 1.5
    stock_type "MyString"
    item_unit nil
    item_category nil
    supply_status false
  end
end
