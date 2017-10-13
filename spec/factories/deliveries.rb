FactoryGirl.define do
  factory :delivery do
    purchase_order ""
    delivery_date ""
    address "MyString"
    accepted_by ""
    accepted_date ""
    checked_by ""
    checked_date ""
    notes "MyString"
    delivery_method "MyString"
    status "MyString"
  end
end
