FactoryGirl.define do
  factory :receive_item do
    purchase_receive nil
    order_item nil
    quantity 1.5
    unit "MyString"
    partial false
    qty_accepted 1.5
    qty_rejected 1.5
    notes "MyString"
  end
end
