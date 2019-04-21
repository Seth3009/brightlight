class Event < ActiveRecord::Base
  belongs_to :department
  belongs_to :manager, class_name: 'Employee'
  belongs_to :creator, class_name: 'Employee'
  has_many :approvals, as: :approvable

  aasm do
    state :draft, initial: true
    state :submitted
    state :approved, :rejected
    state :canceled, :closed 

    event :submit do
      transitions from: [:draft, :rejected, :canceled], to: :submitted
      after do
        set_approvals level: 1
        notify_approvers level: 1
      end
    end

    event :approve do
      transitions from: :submitted, to: :approved
      after do
        set_inactive level: 1
        notify_creator
      end
    end

    event :reject do
      transitions from: :submitted, to: :rejected
      after do
        set_inactive level: 1
        notify_creator
      end
    end

    event :cancel do
      transitions from: :approved, to: :canceled
      after do
        notify_creator
      end
    end

    event :close do
      transitions from: :approved, to: :close
      after do
        notify_creator
      end
    end
  end

  def set_approvals(level:)
    approvers = Approver.for(category:'PR', department: self.department, level: level)  
    self.approvals << Approval.new_from_approvers(approvers) 
  end

  def set_inactive(level:)
    self.approvals.level(level).update_all active: false 
  end

  def notify_creator(reason:)
    if reason == :rejected
      email = EventEmailer.not_approved(self)
    elsif reason == :approved
      email = EventEmailer.approved(self)
    end
    email.deliver_now
    notification = Message.new_from_email(email)
    notification.save
  end
end

