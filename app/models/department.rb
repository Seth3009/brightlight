class Department < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
	has_many :employees, dependent: :restrict_with_error
	has_many :budgets, dependent: :restrict_with_error
	has_many :budget_items, through: :budgets
  belongs_to :manager, class_name: "Employee"
  belongs_to :vice_manager, class_name: "Employee"
  after_save :update_approver_employee

  def update_approver_employee    
    employees = Employee.where(department_id: self.id).all
    if employees.present?
      employees.each do |employee|
        if !employee.leaderships
          if self.manager_id && self.vice_manager_id
            employee.update_column(:approver_id, self.manager_id)
            employee.update_column(:approver_assistant_id, self.vice_manager_id)
          else 
            employee.update_column(:approver_id, self.manager_id)
            employee.update_column(:approver_assistant_id, nil)
          end
        end
      end
    end
  end

	def to_s
		name 
	end
end
