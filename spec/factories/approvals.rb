FactoryGirl.define do
  factory :approval do
    approvable_type "MyString"
    approvable_id 1
    level 1
    approver nil
    approve false
    notes "MyString"
  end
end
