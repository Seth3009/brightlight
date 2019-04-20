namespace :data do
	desc "Populate Requisition Approvals"
  task populate_req_approvals: :environment do
    
    requisitions = Requisition.where.not(sent_to_supv: nil).order(:id)
    requisitions.each.with_index do |r, i|
      next if r.approvals.present?

      approver = Approver.where(category:'PR', employee: r.supervisor).take
      if r.approvals.blank?
        r.approvals << Approval.new(approver: approver, level: 1, approve: r.is_supv_approved, notes: r.req_appvl_notes)
        r.aasm_state = 'level1'
        r.aasm_state = 'approved' if r.is_supv_approved
        r.save
        puts "#{i+1} Req.##{r.id}, #{approver.employee.name} (#{r.is_supv_approved}) notes:#{r.req_appvl_notes}"
      end
    end

  end
end