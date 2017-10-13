FactoryGirl.define do
  factory :req_line_item do
    requisition ""
    description "MyString"
    qty_reqd ""
    unit "MyString"
    est_price ""
    actual_price ""
    currency "MyString"
    notes "MyString"
    qty_ordered ""
    order_date ""
    qty_delivered ""
    delivery_date ""
    qty_accepted ""
    acceptance_date ""
    qty_rejected ""
    needed_by_date ""
    acceptance_notes "MyString"
    reject_notes "MyString"
  end
end
