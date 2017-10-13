FactoryGirl.define do
  factory :order_item do
    purchase_order ""
    stock_item ""
    quantity ""
    unit "MyString"
    min_delivery_qty ""
    pending_qty ""
    type "MyString"
    line_amount ""
    unit_price ""
    currency "MyString"
    deleted ""
    description "MyString"
    status "MyString"
    line_num ""
    extra1 "MyString"
    extra2 "MyString"
  end
end
