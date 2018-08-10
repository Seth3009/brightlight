class Department < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
	has_many :employees, dependent: :restrict_with_error
	has_many :budgets, dependent: :restrict_with_error
	has_many :budget_items, through: :budgets
  belongs_to :manager, class_name: "Employee", foreign_key: 'manager_id'
  belongs_to :vice_manager, class_name: "Employee", foreign_key: 'vice_manager_id'

	def to_s
		name 
	end
end
