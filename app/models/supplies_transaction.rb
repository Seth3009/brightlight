class SuppliesTransaction < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :employee_id
  
  has_many :supplies_transaction_items, -> { order(:id) }, dependent: :destroy  
  validate :has_at_least_one_supplies_transaction_item
  
  accepts_nested_attributes_for :supplies_transaction_items,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['product_id'].blank? || attributes['qty'].blank? }
  
  after_save :update_item_count

  scope :with_employee, lambda { joins('left join employees on employees.id = supplies_transactions.employee_id')}
  scope :filter_query, lambda { |m,y|
    where("EXTRACT(MONTH from transaction_date at time zone 'utc' at time zone 'Asia/Bangkok') = ?",m)
    .where("EXTRACT(YEAR from transaction_date at time zone 'utc' at time zone 'Asia/Bangkok') = ?",y)
  }
  
  def update_item_count 
    self.update_column :itemcount, supplies_transaction_items.count
  end

  private
    def has_at_least_one_supplies_transaction_item
      errors.add :supplies_transaction, 'must have at least one supplies item' if supplies_transaction_items.empty?
    end

end
