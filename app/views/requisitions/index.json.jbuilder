json.array!(@requisitions) do |requisition|
<<<<<<< HEAD
  json.extract! requisition, :id, :req_no,, :description,, :is_budgeted, :budget, :budget_line, :date_required, :date_requested, :department, :requester, :supervisor, :supv_approval, :notes,, :appvl_notes,, :total_amt,, :is_budget_approved, :is_submitted, :is_approved, :is_sent_to_supv, :is_sent_to_purchasing, :is_sent_for_bgt_approval, :is_rejected, :reject_reason,, :active
=======
  json.extract! requisition, :id, :req_no, :department_id, :requester_id, :supv_approved, :supv_notes, :notes, :budgetted, :budget_approved, :bdgt_appvd_by_id, :bdgt_appvd_name, :bdgt_appv_notes, :sent_purch, :sent_supv, :date_sent_supv, :sent_bdgt_appv, :date_sent_bdgt, :date_supv_appvl, :date_bdgt_appvl, :notes, :origin
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  json.url requisition_url(requisition, format: :json)
end
