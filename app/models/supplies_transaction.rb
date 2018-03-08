class SuppliesTransaction < ActiveRecord::Base
  belongs_to :employee
  has_many :supplies_transaction_item
  validates_presence_of :employee
end
