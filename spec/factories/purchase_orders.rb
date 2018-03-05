FactoryGirl.define do
  factory :purchase_order do
    order_num "MyString"
    requestor ""
    order_date ""
    due_date ""
    total_amount ""
    is_active ""
    currency "MyString"
    deleted ""
    notes "MyString"
    completed_date ""
    supplier ""
    contact "MyString"
    phone_contact "MyString"
    user ""
    status "MyString"
  end
end
