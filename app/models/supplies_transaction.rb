class SuppliesTransaction < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :employee_id
  has_many :supplies_transaction_items, -> { order(:id) }, dependent: :destroy  
  accepts_nested_attributes_for :supplies_transaction_items, reject_if: :all_blank, allow_destroy: true
  
  scope :with_employee, lambda { joins('left join employees on employees.id = supplies_transactions.employee_id')}

  def self.count_item(supplies_transaction)
    count_item = SuppliesTransactionItem.where(:supplies_transaction_id => supplies_transaction).count
    if count_item
      SuppliesTransaction.find(supplies_transaction).update(itemcount: count_item)
    end
  end
end
