class SuppliesTransaction < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :employee
  has_many :supplies_transaction_items, -> { order(:id) }, dependent: :destroy  
  accepts_nested_attributes_for :supplies_transaction_items, reject_if: :all_blank, allow_destroy: true
  
end
