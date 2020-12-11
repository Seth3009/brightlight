FactoryGirl.define do
  factory :fund_request do
    requester_id 1
    date_request "2020-11-12"
    date_needed "2020-11-12"
    description "MyString"
    amount ""
    payment_type "MyString"
    is_budgeted false
    budget_notes "MyString"
    is_spv_approved false
    spv_approval_notes "MyString"
    spv_approval_date "2020-11-12"
    is_hos_approved false
    hos_approval_notes "MyString"
    hos_approval_date "2020-11-12"
    receiver_id 1
    received_date "2020-11-12"
  end
end
