class Requisition < ActiveRecord::Base
  include AASM 

  belongs_to :department
  belongs_to :requester, class_name: 'Employee'
  belongs_to :supervisor, class_name: 'Employee'
  belongs_to :req_approver, class_name: 'Employee'
  belongs_to :budget_approver, class_name: 'Employee'
  belongs_to :purch_receiver, class_name: 'Employee'
  belongs_to :budget
  belongs_to :account
  belongs_to :budget_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :event

  has_many :req_items, -> { order(:id) }, dependent: :destroy
  has_many :po_reqs
  has_many :purchase_orders, through: :po_reqs
  has_many :approvals, as: :approvable

  accepts_nested_attributes_for :req_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :approvals, reject_if: :all_blank

  validates :department, presence: true
  validates :requester, presence: true
  validates :description, presence: true
  validates_inclusion_of :is_budgeted, in: [true, false], message: 'is required. Please indicate whether the request is budgeted or not'
  validate  :at_least_one_req_item

  acts_as_commentable
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true

  before_save :update_total

  Statuses = {:new    => {code: "NEW",    description: "New"},
              :wappr  => {code: "WAPPR",  description: "Waiting for Approval"},
              :wbgapv => {code: "WBGAPV", description: "Waiting for Budget Approval"},
              :appvd  => {code: "APPVD",  description: "Approved"},
              :open   => {code: "OPEN",   description: "Purchase Order created"},
              :close  => {code: "CLOSE",  description: "All items ordered"},
              :cancel => {code: "CANCEL", description: "Canceled"}}

  scope :with_approval_by, lambda { |employee| 
    joins(approvals: [:approver])
    .where('approvers.employee_id = ?', employee.id)
    .uniq
  }
  scope :pending_supv_approval, lambda { |employee|
    with_approval_by(employee)
    .where('approvals.approve is null')
  }
  scope :pending_approval, lambda { where(aasm_state: ['level1', 'level2', 'level3']) }
  scope :approved, lambda { where("aasm_state = 'approved' OR aasm_state = 'open'") }
  scope :draft, lambda { where(aasm_state: 'draft') }
  scope :rejected, lambda { where(aasm_state: 'rejected') }
  scope :active, lambda { where(active: true) }

  aasm do
    state :draft, initial: true
    state :approval_for_event
    state :level1, :level2, :level3
    state :approved, :rejected
    state :open, :canceled, :closed 

    event :submit do
      transitions from: :draft, to: :level1
      transitions from: :draft, to: :approval_for_event, if: :event?
      after do
        if event?
          set_approvals event: self.event
          notify_approvers event: self.event
        else
          set_approvals level: 1
          notify_approvers level: 1
        end
      end
    end

    event :l1_approve do
      transitions from: :level1, to: :approved, if: :budgeted?
      transitions from: :level1, to: :level2, unless: :budgeted?
      after do
        set_inactive level: 1
        if is_budgeted
          notify_purchasing 
        else
          set_approvals level: 2
          notify_approvers level: 2
        end
      end
    end

    event :l2_approve do
      transitions from: :level2, to: :approved, if: :budgeted?
      transitions from: :level2, to: :level3, unless: :budgeted?
      after do
        set_inactive level: 2
        if is_budgeted
          notify_purchasing 
        else
          set_approvals level: 3
          notify_approvers level: 3
        end
      end
    end

    event :l3_approve do
      transitions from: :level3, to: :approved
      after do
        set_inactive level: 3
        notify_purchasing if l3_approved?
      end
    end

    event :reject do
      transitions from: [:level1, :level2, :level3], to: :rejected,
        after: Proc.new {|level| 
          set_inactive level: level
          notify_requester reason: :rejected, level: level
        }
    end

    event :open_order do
      transitions from: :approved, to: :open
    end
  
  end

  def set_approvals(level: nil, event: nil)
    if event.present?
      approvers = Approver.for(category:'PR', event: event)
    else
      approvers = if level == 3 
                    Approver.for(category:'PR', level: level)
                  else
                    Approver.for(category:'PR', department: self.department, level: level)  
                  end
    end
    self.approvals << Approval.new_from_approvers(approvers) 
  end

  def set_inactive(level:)
    self.approvals.level(level).update_all active: false 
  end

  def event?
    self.event_id.present?
  end

  def budgeted?
    self.is_budgeted
  end

  def l1_approved?
    self.approvals.level(1).any? &:approve
  end

  def l2_approved?
    self.approvals.level(2).any? &:approve
  end

  def l3_approved?
    self.approvals.level(3).any? &:approve
  end

  def l1_rejected?
    self.approvals.level(1).any? {|x| x.approve == false}
  end

  def l2_rejected?
    self.approvals.level(2).any? {|x| x.approve == false}
  end

  def l3_rejected?
    self.approvals.level(3).any? {|x| x.approve == false}
  end

  def notify_requester(reason:, level:)
    if reason == :rejected
      email = RequisitionEmailer.not_approved(self, level: level)
      email.deliver_now
      notification = Message.new_from_email(email)
      notification.save
    end
  end

  def notify_approvers(level: 1, event: nil)
    approvers = self.approvals.level(level)
    email = RequisitionEmailer.approval(self, approvers)
    email.deliver_now
    notification = Message.new_from_email(email)
    notification.save
    if level == 1
      self.update_attributes sent_to_supv: Date.today
    else
      self.update_attributes sent_for_bgt_approval: Date.today
    end
  end

  def notify_purchasing
    email = RequisitionEmailer.requisition_to_purchasing(self)
    email.deliver_now
    notification = Message.new_from_email(email)
    notification.save
    self.status = Requisition.status_code(:appvd)
    self.sent_to_purchasing = Date.today
    self.is_submitted = true
    save
  end

  def is_pending_approval_by(employee)
    approvals.active.joins(:approver).where('approvers.employee_id = ?', employee.id)
    .where(approvals: {approve: nil}).present? &&
    !(['approved', 'rejected'].include? aasm_state)
  end

  def pending_supv_approval?
    # status == Requisition.status_code(:wappr) # && sent_to_supv != nil && is_supv_approved == nil
    self.level1? 
  end

  def pending_budget_approval?
    # status == Requisition.status_code(:wbgapv) #&& !is_budgeted && sent_for_bgt_approval != nil && is_budget_approved == nil
    self.level2? || self.level3?
  end

  def submitted?
    sent_to_supv.present?
  end

  # Call back from comment
  def create_email_from_comment(comment)
    # Purchasing email is set in Rails configuration file
    purchasing_email = Rails.application.config.purchasing_email_address
    purchasing = Employee.find_by_email /<(.+)>/.match(purchasing_email)[1]
    # Send email to requester, supervisor and purchasing, except the comment originator
    addressee = [self.requester, purchasing].reject {|n| n.id == comment.user.employee.try(:id)}
    EmailNotification.new_comment comment, addressee.map { |e| %("#{e.name}" <#{e.try(:email)}>) }
  end

  def user
    requester 
  end

  def number_of_unordered_items
    req_items.where(order_item_id: nil).count
  end

  def all_items_ordered? 
    self.req_items.reduce(true) do |acc, req_item| 
      acc && req_item.order_item.present?
    end
  end

  def self.status_code(status)
    Requisition::Statuses[status][:code]
  end

  def update_status
    unordered_items_count = number_of_unordered_items
    if unordered_items_count == 0
      update_columns(status: Requisition.status_code(:close))
    elsif unordered_items_count != req_items.count
      update_columns(status: Requisition.status_code(:open))
    else
      update_columns(status: Requisition.status_code(:appvd))
    end
  end
  
  private

    def at_least_one_req_item
      # when creating a new requisition: making sure at least one item exists
      return errors.add :base, "Must have at least one item" unless req_items.length > 0
      # when updating an existing contact: Making sure that at least one item would exist
      return errors.add :base, "Must have at least one item" if req_items.reject{|item| item._destroy == true}.empty?
    end

    def update_total
      self.total_amt = self.req_items.sum :est_price
    end
end