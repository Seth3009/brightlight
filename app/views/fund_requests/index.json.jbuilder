json.array!(@fund_requests) do |fund_request|
  json.extract! fund_request, :id, :requester_id, :date_request, :date_needed, :description, :amount, :payment_type, :is_budgeted, :budget_notes, :is_spv_approved, :spv_approval_notes, :spv_approval_date, :is_hos_approved, :hos_approval_notes, :hos_approval_date, :receiver_id, :received_date
  json.url fund_request_url(fund_request, format: :json)
end
