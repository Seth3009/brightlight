json.extract! @requisition, :id, :req_no, :description, :is_budgeted, :budget, :budget_line, :date_required, :date_requested, :department, 
  :requester, :supervisor, :supv_approval, :notes, :appvl_notes, :total_amt,, :is_budget_approved, :is_submitted, :is_approved, :is_sent_to_supv, 
  :is_sent_to_purchasing, :is_sent_for_bgt_approval, :is_rejected, :reject_reason, :active, :created_at, :updated_at
