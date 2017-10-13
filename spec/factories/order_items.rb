FactoryGirl.define do
  factory :order_item do
<<<<<<< HEAD
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
=======
    purchase_order nil
    no 1
    order_date "2017-05-24"
    supplier "MyString"
    supplier_id 1
    req_line nil
    invoice_amt "9.99"
    dp_amount "9.99"
    dp_date "2017-05-24"
    notes "MyString"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
