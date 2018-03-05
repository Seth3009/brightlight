class Employee < ActiveRecord::Base
 	validates :name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, allow_blank: true
    
 	belongs_to :user
	belongs_to :department
	belongs_to :supervisor, class_name: "Employee"
	has_many :subordinates, class_name: "Employee", foreign_key: "supervisor_id", dependent: :restrict_with_error
  has_many :book_loans
  has_many :grade_sections, foreign_key: "homeroom_id"
	has_many :course_sections, foreign_key: "instructor_id"
	has_one :manager, through: :department
	has_many :leave_requests

  accepts_nested_attributes_for :book_loans,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['book_copy_id'].blank? }

	scope :all_teachers, lambda { where(job_title:'Teacher') }
  scope :active, lambda { where(is_active:true).order(:name) }
	scope :with_book_loans, lambda { |year|
		joins(:book_loans)
    .where(book_loans: {academic_year_id: year || AcademicYear.current_id})
		.order(:name).uniq
	}
	scope :department_heads, lambda { joins('join departments on employees.id = departments.manager_id').order(:name) }
	scope :supervisors, lambda { 
		where('id in (select supervisor_id from employees where supervisor_id is not null)')
		.select(:id, :name)
	}

	def is_manager?
		Department.all.map(&:manager_id).include? self.id
	end
	
	def to_s
		name
	end
end
