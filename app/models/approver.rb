class Approver < ActiveRecord::Base
  belongs_to :employee
  belongs_to :department
  belongs_to :event
  has_many :approvals, dependent: :nullify
  
  validates :employee, presence: true
  validates :category, presence: true

  scope :active, -> { where.not(active: false) }
  scope :with_names, -> { 
    joins('left join employees on employees.id = approvers.employee_id')
    .joins('left join departments on departments.id = approvers.department_id')
    .joins('left join events on events.id = approvers.event_id')
    .select('approvers.*, employees.name as employee_name, departments.name as department_name, events.name as event_name')
  }
  scope :for_leave_requests, -> { where(category: 'LR') }
  scope :for_purchase_requests, -> { where(category: 'PR') }
  scope :for_fund_requests, -> { where(category: 'FR') }
  scope :for_events, -> { where(category: 'EV') }
  scope :level, -> (lvl) { where(level: lvl) }
  scope :for_department, -> (dept) { where(department: dept) }
  
  def self.for(category:, department: nil, event: nil, level: 1)
    if event.present?
      where(category: category, event: event)
    else
      where(category: category, department: department, level: level)
    end
  end
end
