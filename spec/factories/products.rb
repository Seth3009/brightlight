FactoryGirl.define do
  factory :product do
    code "MyString"
    name "MyString"
    price "9.99"
    min_stock 1.5
    max_stock 1.5
    stock_type "MyString"
    item_unit nil
    item_category nil
    is_active false
    img_url "MyString"
  end
end
