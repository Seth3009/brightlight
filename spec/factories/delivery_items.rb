FactoryGirl.define do
  factory :delivery_item do
    delivery ""
    order_item ""
    quantity ""
    unit "MyString"
    accepted_by ""
    accepted_date ""
    checked_by ""
    checked_date "MyString"
    notes "MyString"
    is_accepted ""
    is_rejected ""
    reject_notes "MyString"
    accept_notes "MyString"
  end
end
