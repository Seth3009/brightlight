FactoryGirl.define do
  factory :budget do
<<<<<<< HEAD
    department ""
    grade_level ""
    grade_section ""
    budget_holder ""
    academic_year ""
    is_submitted ""
    submit_date ""
    is_approved ""
    approved_date ""
    approver ""
    is_received ""
    receiver ""
    received_date ""
    total_amt ""
    notes "MyString"
    category "MyString"
    type "MyString"
    group "MyString"
    version "MyString"
=======
    department nil
    owner nil
    grade_level nil
    grade_section nil
    academic_year nil
    submitted false
    submit_date "2017-05-24"
    approved false
    apprv_date "2017-05-24"
    approver nil
    type ""
    category "MyString"
    active false
    notes "MyString"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
