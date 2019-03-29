class Approver < ActiveRecord::Base
  belongs_to :employee
  belongs_to :department
  belongs_to :event

  validates :employee, presence: true
  validates :category, presence: true

  scope :active, -> { where.not(active: false) }
end
