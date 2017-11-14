class Department < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
	has_many :employees, dependent: :restrict_with_error
	belongs_to :manager, class_name: "Employee", foreign_key: 'manager_id'

	def to_s
		name 
	end
end
