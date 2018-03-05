FactoryGirl.define do
  factory :requisition do
    req_no "MyString"
    description "MyString"
    is_budgeted ""
    budget ""
    budget_line ""
    date_required ""
    date_requested ""
    department ""
    requester ""
    supervisor ""
    supv_approval ""
    notes "MyString"
    appvl_notes "MyString"
    total_amt "MyString"
    is_budget_approved ""
    is_submitted ""
    is_approved ""
    is_sent_to_supv ""
    is_sent_to_purchasing ""
    is_sent_for_bgt_approval ""
    is_rejected ""
    reject_reason "MyString"
    active false
  end
end
