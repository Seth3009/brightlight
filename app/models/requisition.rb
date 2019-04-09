class Requisition < ActiveRecord::Base
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
  
  has_many :req_items, -> { order(:id) }, dependent: :destroy
  has_many :po_reqs
  has_many :purchase_orders, through: :po_reqs

  accepts_nested_attributes_for :req_items, reject_if: :all_blank, allow_destroy: true

  validates :department, presence: true
  validates :requester, presence: true
  validates :description, presence: true
  validates_inclusion_of :is_budgeted, in: [true, false], message: 'is required. Please indicate whether the request is budgeted or not'
  validate  :at_least_one_req_item

  acts_as_commentable
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true

  Statuses = {:new    => {code: "NEW",    description: "New"},
              :wappr  => {code: "WAPPR",  description: "Waiting for Approval"},
              :wbgapv => {code: "WBGAPV", description: "Waiting for Budget Approval"},
              :appvd  => {code: "APPVD",  description: "Approved"},
              :open   => {code: "OPEN",   description: "Purchase Order created"},
              :close  => {code: "CLOSE",  description: "All items ordered"},
              :cancel => {code: "CANCEL", description: "Canceled"}}

  scope :pending_supv_approval, lambda { |employee|
    where(department: employee.try(:department))
    .where.not(sent_to_supv: nil).where(is_supv_approved: nil).where(supervisor_id: employee.id)
    .order(:id)
  }

  scope :pending_budget_approval, lambda { |employee|
    where(is_supv_approved: true)
    .where.not(sent_for_bgt_approval: nil).where(is_budget_approved: nil).where(budget_approver_id: employee.id)
    .order(:id)
  }

  scope :pending_approval, lambda {
    where('(sent_to_supv is not null AND is_supv_approved is null)
            OR (sent_for_bgt_approval is not null and is_budget_approved is null)')
    .order(:id)
  }

  scope :approved, lambda {
    where('(is_supv_approved = true AND is_budget_approved = true)
           OR (is_supv_approved = true AND is_budgeted = true)')
    .order(:id)
  }

  def send_for_approval(approver, type)
    if approver
      email = EmailNotification.req_approval(self, approver, type)
      email.deliver_now
      notification = Message.new_from_email(email)
      notification.save
      if type == 'supv'
        self.update_attributes status: Requisition.status_code(:wappr)
        self.update_attributes sent_to_supv: Date.today, supervisor: approver
      elsif type == 'budget'
        self.update_attributes status: Requisition.status_code(:wbgapv)
        self.update_attributes sent_for_bgt_approval: Date.today
      end
    else
      return false
    end
    return true
  end 

  def send_to_purchasing
    purchasing_email = Rails.application.config.purchasing_email_address
    email = EmailNotification.requisition_to_purchasing(self, purchasing_email)
    email.deliver_now
    notification = Message.new_from_email(email)
    notification.save
    self.status = Requisition.status_code(:appvd)
    self.sent_to_purchasing = Date.today
    self.is_submitted = true
    save
  end

  def pending_supv_approval?
    status == Requisition.status_code(:wappr) # && sent_to_supv != nil && is_supv_approved == nil
  end

  def pending_budget_approval?
    status == Requisition.status_code(:wbgapv) #&& !is_budgeted && sent_for_bgt_approval != nil && is_budget_approved == nil
  end

  def draft?
    !submitted?
  end

  def submitted?
    sent_to_supv.present?
  end

  def approved?
    (is_supv_approved && is_budget_approved) || (is_supv_approved && is_budgeted)
  end

  # Call back from comment
  def create_email_from_comment(comment)
    # Purchasing email is set in Rails configuration file
    purchasing_email = Rails.application.config.purchasing_email_address
    purchasing = Employee.find_by_email /<(.+)>/.match(purchasing_email)[1]
    # Send email to requester, supervisor and purchasing, except the comment originator
    addressee = [self.requester, self.supervisor, purchasing].reject {|n| n.id == comment.user.employee.try(:id)}
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

end