class FundRequest < ActiveRecord::Base
  include AASM 

  scope :with_approval_by, lambda { |employee| 
    joins(approvals: [:approver])
    .where('approvers.employee_id = ?', employee.id)
    .uniq
  }
  
  scope :pending_approval, lambda { where(aasm_state: ['level1', 'level2', 'level3']) }

  scope :submitted, -> { where(is_submitted: true) }

  scope :draft, -> { where(is_submitted: false) }

  def draft?
    !submitted?
  end

  def submitted?
    is_submitted = true
  end
end
