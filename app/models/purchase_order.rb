class PurchaseOrder < ActiveRecord::Base
  include AASM 

  belongs_to :department
  belongs_to :requestor, class_name: 'Employee'
  belongs_to :approver, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :supplier
  belongs_to :buyer, class_name: 'User'

  has_many :order_items, dependent: :destroy
  has_many :deliveries
  has_many :po_reqs, dependent: :destroy
  has_many :requisitions, through: :po_reqs
  has_many :req_items, through: :order_items
  has_many :receive_items, through: :order_items
  
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
  #validate  :at_least_one_order_item

  after_create :assign_po_number

  aasm column: 'status' do
    state :requested, initial: true
    state :ordered
    state :acknowledged
    state :partial
    state :completed
    state :canceled
    state :close

    event :order do
      transitions from: :requested, to: :ordered
      after do
        notify_requesters { |req, po| PurchaseOrderEmailer.open_po req, po }
      end
    end

    event :acknowledge do
      transitions from: :ordered, to: :acknowledged
      after do
        fill_in_actuals
      end
    end

    event :receive_partial do
      transitions from: [:requested, :completed, :ordered, :acknowledged, :partial], to: :partial
    end

    event :receive_full do
      transitions from: [:requested, :ordered, :acknowledged, :partial], to: :completed
    end

    event :cancel do
      transitions from: [:requested, :ordered, :acknowledged], to: :canceled
      after do
        notify_requesters { |req, po| PurchaseOrderEmailer.cancel_po req, po }
      end
    end
  end

  def self.new_from_requisition(req)
    purchase_order = PurchaseOrder.new 
    purchase_order.requisitions << req
    purchase_order.requestor_id = req.requester_id
    purchase_order.department_id = req.department_id
    purchase_order.due_date = req.date_required
    req.req_items.incomplete.each do |item|
      purchase_order.order_items.build(
        description: item.description,
        quantity: item.qty_reqd,
        unit: item.unit,
        unit_price: item.est_price,
        currency: item.currency,
        req_item_id: item.id
      )
    end
    purchase_order
  end

  def status_description
    self.status.try(:humanize)
  end

  def unique_requests
    Requisition.joins(req_items: :order_item).where(order_items: {purchase_order_id: self.id}).uniq
  end

  def notify_requesters
    self.unique_requests.each do |req|
      unless req.open?
        req.open_order!
        email = yield req, self
        email.deliver_now
        Message.create_from_email(email)
      end
    end
  end

  def fill_in_actuals
    self.order_items.each do |item|
      item.actual_amt = item.line_amount
      item.save
    end
  end

  def pending_delivery?
    !order_items.all? &:all_received?
  end

  def self.index_table
    joins('left join suppliers on purchase_orders.supplier_id = suppliers.id')
    .joins('left join employees on purchase_orders.requestor_id = employees.id')
    .select('purchase_orders.*, purchase_orders.status as order_status, suppliers.company_name as supplier_name, employees.name as requestor_name')
  end

  def receive
    pending_delivery? ? receive_partial : receive_full
  end

  def receive!
    pending_delivery? ? receive_partial! : receive_full!
  end

  def delivery_address
    "#{dlvry_address}<br>#{dlvry_address2}<br>#{dlvry_city} #{dlvry_post_code}".html_safe
  end


  private

    def at_least_one_order_item
      # when creating a new record
      return errors.add :base, "Must have at least one item" unless order_items.length > 0
      # when updating an existing record
      return errors.add :base, "Must have at least one item" if order_items.reject{|item| item._destroy == true}.empty?
    end

    def assign_po_number
      self.order_num = id 
      self.save
    end 
end
