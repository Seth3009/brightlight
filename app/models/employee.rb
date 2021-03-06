class Employee < ActiveRecord::Base
 	validates :name, :department, :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, allow_blank: true
  after_save :auto_fill_approver  
 	belongs_to :user
	belongs_to :department
  belongs_to :supervisor, class_name: "Employee" 
  belongs_to :approver, class_name: "Employee"
  belongs_to :approver_assistant, class_name: "Employee"
	has_many :subordinates, class_name: "Employee", foreign_key: "supervisor_id", dependent: :restrict_with_error
  has_many :book_loans, dependent: :restrict_with_error
  has_many :grade_sections, foreign_key: "homeroom_id"
	has_many :course_sections, foreign_key: "instructor_id"
  has_one :manager, through: :department
	has_many :leave_requests
  has_many :supplies_transaction
  has_one :employee_smartcard
  has_one :badge

  accepts_nested_attributes_for :book_loans,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['book_copy_id'].blank? }

	scope :all_teachers, lambda { where(department_id: Department.academic.map(&:id) ).order(:name) }
  scope :active, lambda { where(is_active:true).order(:name) }
	scope :with_book_loans, lambda { |year|
		joins(:book_loans)
    .where(book_loans: {academic_year_id: year || AcademicYear.current_id})
		.order(:name).uniq
  }

  scope :with_badge_code, lambda { |code|
    joins(:badge)
    .where(badges: {code: code})
  }
  
	scope :department_heads, lambda { 
    joins('join departments on employees.id = departments.manager_id or employees.id = departments.vice_manager_id')
    .joins('join (select * from employees where supervisor_id is not null) supv on supv.id = employees.id')
    .order(:name) 
  }

	scope :supervisors, lambda { 
		where('id in (select supervisor_id from employees where supervisor_id is not null)')
  }
  
  def superiors
    [supervisor, department.try(:managers), supervisor.try(:supervisor), manager.try(:supervisor)]
      .flatten.uniq
      .reject{|e| e == self}
      .reject &:nil?
  end

  def self.with_role(role)
    role_mask = User::ROLES.index(role)
    Employee.joins(:user).where('users.roles_mask & (1 << ?) != 0', role_mask)
  end

  def self.budget_approvers 
    Employee.with_role :approve_budget
  end

	def is_manager?
		Department.all.map(&:manager_id).include? self.id
	end
  
  scope :search_query, lambda { |query|
    return nil  if query.blank?   
      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)

      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conds = 3
      joins('left join departments on departments.id = employees.department_id')
      .where(
        terms.map { |term|
          "(LOWER(employees.name) LIKE ? OR LOWER(departments.name) LIKE ? OR LOWER(job_title) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  def auto_fill_approver    
    manager = Department.find(self.department_id).manager_id    
      if !self.leaderships
        if manager.present? 
          self.update_column(:approver_id, manager)
        else
          self.update_column(:approver_id, manager)          
        end
      end
  end  

  

	def to_s
		name
	end
end
