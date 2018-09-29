class PurchaseOrder < ActiveRecord::Base
  belongs_to :department
  belongs_to :requestor, class_name: 'Employee'
  belongs_to :approver, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  belongs_to :supplier
  belongs_to :buyer, class_name: 'User'

  has_many :order_items
  has_many :deliveries
  has_many :po_reqs
  has_many :requisitions, through: :po_reqs

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
  validate  :at_least_one_order_item

  private

    def at_least_one_order_item
      # when creating a new record
      return errors.add :base, "Must have at least one item" unless order_items.length > 0
      # when updating an existing record
      return errors.add :base, "Must have at least one item" if order_items.reject{|item| item._destroy == true}.empty?
    end
end
