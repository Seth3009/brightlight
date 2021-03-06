class Department < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
	has_many :employees, -> { active }, dependent: :restrict_with_error
	has_many :budgets, dependent: :restrict_with_error
  has_many :budget_items, through: :budgets
  has_many :account_departments
  has_many :accounts, through: :account_departments
  belongs_to :manager, class_name: "Employee", foreign_key: 'manager_id'
  belongs_to :vice_manager, class_name: "Employee", foreign_key: 'vice_manager_id'
  after_save :update_approver_employee

  scope :academic, -> { where(:code => ['EC', 'GS', 'SOL', 'SOR', 'CURR']) }

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

  def managers
    [manager, vice_manager]
  end

	def to_s
		name 
	end
end
