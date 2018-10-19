class PurchaseOrder < ActiveRecord::Base
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

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
  validate  :at_least_one_order_item

  after_create :assign_po_number


  def self.new_from_requisition(req)
    purchase_order = PurchaseOrder.new 
    purchase_order.requisitions << req
    purchase_order.requestor_id = req.requester_id
    purchase_order.department_id = req.department_id
    purchase_order.due_date = req.date_required
    req.req_items.each do |item|
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
