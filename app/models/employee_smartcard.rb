class EmployeeSmartcard < ActiveRecord::Base
  belongs_to :employee
  validates :employee_id, uniqueness: true, presence: true
end
