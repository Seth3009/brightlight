FactoryGirl.define do
  factory :supplies_transaction_item do
    supplies_transaction nil
    product nil
    in_out "MyString"
    qty 1.5
  end
end
