class Event < ActiveRecord::Base
  include AASM
  
  belongs_to :department
  belongs_to :manager, class_name: 'Employee'
  belongs_to :creator, class_name: 'Employee'
  has_many :approvals, as: :approvable
  has_many :approvers

  accepts_nested_attributes_for :approvers, reject_if: :all_blank, allow_destroy: true
  
  scope :active, -> { where(active: true) }
  scope :current, -> { where(academic_year_id: AcademicYear.current_id) }
  
  aasm do
    state :draft, initial: true
    state :submitted
    state :approved, :rejected
    state :canceled, :closed 

    event :submit do
      transitions from: [:draft, :rejected, :canceled], to: :submitted
      after do
        set_approvals level: 1
      end
    end

    event :approve do
      transitions from: :submitted, to: :approved
      after do
        set_inactive level: 1
      end
    end

    event :reject do
      transitions from: :submitted, to: :rejected
      after do
        set_inactive level: 1
      end
    end

    event :cancel do
      transitions from: :approved, to: :canceled
    end

    event :close do
      transitions from: :approved, to: :close
    end
  end

  def set_approvals(level:)
    approvers = Approver.for(category:'EV', department: self.department, level: level)  
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

  def self.notify_approvers(event_ids)
    approver_and_events = Approver.joins(:approvals)
      .where(approvals: {approvable_type:'Event', approvable_id: event_ids})
      .joins(:employee)
      .select('approvers.*, employees.email as email, approvals.approvable_id as event_id')
      .order('employees.id')
      .reduce({}){|map, a| map[a.email] ? map.merge(a.email => map[a.email].push(a.event_id)) : map.merge(a.email => [a.event_id]) }
    approver_and_events.each do |email, events|
      email = EventEmailer.approval(email, events)
      email.deliver_now
      notification = Message.new_from_email(email)
      notification.save
    end
  end
end

