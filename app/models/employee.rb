class Employee < ActiveRecord::Base
 	validates :name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
    
 	belongs_to :user
	belongs_to :department
	belongs_to :supervisor, class_name: "Employee"
	has_many :subordinates, class_name: "Employee", foreign_key: "supervisor_id", dependent: :restrict_with_error
  has_many :book_loans
  has_many :grade_sections, foreign_key: "homeroom_id"
	has_many :course_sections, foreign_key: "instructor_id"
	has_many :supplies_transaction

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

	def to_s
		name
	end
end
