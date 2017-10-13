FactoryGirl.define do
  factory :budget_item do
<<<<<<< HEAD
    budget ""
    description "MyString"
    account "MyString"
    line ""
    notes "MyString"
    academic_year ""
    month ""
    amount ""
    actual_amt ""
    is_completed ""
    type "MyString"
    category "MyString"
    group "MyString"
=======
    budget nil
    description "MyString"
    notes "MyString"
    amount "9.99"
    currency "MyString"
    used_amount "9.99"
    completed false
    appvl_notes "MyString"
    approved false
    approver nil
    date_approved "2017-05-24"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
