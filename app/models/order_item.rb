class OrderItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :req_item
  belongs_to :stock_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :delivery_items

  validates :req_item_id, presence: true
  validates_uniqueness_of :req_item_id, message: "Requested item has been ordered before."
  validates_numericality_of :quantity, greater_than_or_equal_to: 0
  validates_presence_of :quantity, :unit_price, :discount, :est_tax, :non_recurring, :shipping

  after_save :calc_line_amount
  after_save :sync_req_item
  before_destroy :remove_link_with_req_item

  scope :with_po_records, lambda { 
    joins(:purchase_order)
    .joins('left join suppliers on suppliers.id = purchase_orders.supplier_id')
    .joins(:req_item)
    .joins('left join requisitions on requisitions.id = req_items.requisition_id')
    .joins('left join employees on employees.id = requisitions.requester_id')
    .joins('left join accounts on accounts.id = requisitions.account_id')
    .select('order_items.*, purchase_orders.currency as currency, requisitions.id as fpb, employees.name as requestor_name, accounts.description as budget, suppliers.company_name as supplier')
    .order('requisitions.id')
  }

  def self.po_records(date: nil, supplier: nil, account: nil, item: nil)
    records = self.with_po_records
    records = records.where(purchase_orders: {order_date: date}) if date.present?
    records = records.where(purchase_orders: {supplier_id: supplier}) if supplier.present?
    records = records.where(accounts: {id: account}) if account.present?
    records = records.where(description: item) if item.present?
    records
  end
  
  def self.new_from_req_items(req_items)
    req_items.map {|req_item|
      new(description: req_item.description,
        quantity: req_item.qty_reqd,
        unit: req_item.unit,
        unit_price: req_item.est_price,
        currency: req_item.currency,
        req_item_id: req_item.id
      )
    }
  end

  def requisition
    req_item.try(:requisition)
  end

  def requestor
    requisition.try(:requester)
  end

  private

    def sync_req_item
      req_item.update_columns order_item_id: self.id
      req_item.requisition.update_status
    end

    def remove_link_with_req_item
      req_item.update_columns order_item_id: nil
      req_item.requisition.update_status
    end

    def calc_line_amount
      update_column :line_amount, unit_price * quantity - discount + est_tax + non_recurring + shipping       # - down_payment
    end

end
