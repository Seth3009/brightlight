FactoryGirl.define do
  factory :purchase_receive, class: 'PurchaseReceive' do
    purchase_order nil
    date_received "2019-10-18"
    date_checked "2019-10-18"
    receiver_id 1
    checker_id 1
    notes "MyString"
    partial false
    status "MyString"
  end
end
