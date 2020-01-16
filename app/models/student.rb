class Student < ActiveRecord::Base

  has_many :grade_sections_students
	has_many :grade_sections, through: :grade_sections_students
	has_many :course_sections, through: :rosters
  has_many :rosters, dependent: :destroy
	has_one  :student_admission_info, autosave: true
	has_many :student_books, dependent: :restrict_with_error
	has_many :book_loans, dependent: :restrict_with_error
	has_many :book_fines, dependent: :restrict_with_error
	has_one  :passenger
	has_one  :transport, through: :passenger
  has_one  :badge
  has_many :activity_schedules, through: :student_activities
	has_many :student_activities, :dependent => :destroy
	has_many :diknas_report_cards, :dependent => :destroy

	belongs_to :family

  validates :name, presence: true
	validates :student_no, uniqueness: true, presence: true

	accepts_nested_attributes_for :student_books, allow_destroy: true, reject_if: :all_blank
	accepts_nested_attributes_for :book_loans, allow_destroy: true, reject_if: :all_blank

	scope :current, lambda { joins('INNER JOIN grade_sections_students ON grade_sections_students.student_id = students.id
											INNER JOIN grade_sections ON grade_sections.id = grade_sections_students.grade_section_id')
											.joins('LEFT JOIN "employees" ON "employees"."id" = "grade_sections"."homeroom_id"')
		.where(grade_sections_students: {academic_year: AcademicYear.current}) }
  
	scope :with_academic_year, lambda {|academic_year|
		joins(:grade_sections_students)
			.where(grade_sections_students: {academic_year: academic_year}) }

	scope :for_section, lambda {|section, year:AcademicYear.current|
		joins('INNER JOIN "grade_sections_students" ON "grade_sections_students"."student_id" = "students"."id"	INNER JOIN "grade_sections" ON "grade_sections"."id" = "grade_sections_students"."grade_section_id"') 
		.where(grade_sections_students: {grade_section: section, academic_year: year})
		.select('students.id, students.name, students.family_no, grade_sections_students.grade_section_id, grade_sections_students.order_no, grade_sections.name as grade')
			.order('grade_sections_students.order_no')
	}

	scope :with_grade_section, lambda {|year: AcademicYear.current|
		joins(:grade_sections_students)
		.where(grade_sections_students: {academic_year: year})
		.joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
		.joins('left join grade_levels on grade_levels.id = grade_sections.grade_level_id')
		.select('students.*, grade_sections.id as gs_id, grade_sections.name as gs_name, grade_levels.id as gl_id, grade_levels.name as gl_name')
	}

	scope :search_name, lambda { |name| where('UPPER(students.name) LIKE ?', "%#{name.upcase}%") }

	scope :student_tardy_search, lambda { |tardy_term| 
				where('UPPER(students.name) LIKE ? or UPPER(grade_sections.name) LIKE ? or students.family_no LIKE ?', "%#{tardy_term.upcase}%","%#{tardy_term.upcase}%","%#{tardy_term.upcase}%") }

  filterrific(
    default_filter_params: { sorted_by: 'name_asc' },
    available_filters: [
      :sorted_by,
			:search_query,
			:with_grade_level_id,
			:with_grade_section_id,
      :filtered_by
    ]
	)
	
	scope :with_grade_level_id, lambda { |grade_level_id|
		with_grade_section
		.where('grade_levels.id = ?', grade_level_id)
	}

	scope :with_grade_section_id, lambda { |grade_section_id|
		with_grade_section
		.where('grade_section.id = ?', grade_section_id)
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
    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(students.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^name/
			order("LOWER(students.name) #{ direction }")
		when /^grade_level/
			with_grade_section.order("grade_levels.name #{ direction}, LOWER(students.name) asc")
		when /^grade_section/
			with_grade_section.order("grade_sections.name #{ direction}, LOWER(students.name) asc")
    when /^family_no/
      order("LOWER(students.family_no) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
	}

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
			['Grade Level', 'grade_level_asc'],
			['Grade Section', 'grade_section_asc'],
      ['Family No', 'family_no_asc']
    ]
  end

  scope :filtered_by, lambda { |filter_option|
    where('grade_sections.id=?', filter_option)
  }

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |student|
        csv << student.attributes.values_at(*column_names)
      end
    end
  end

	def current_grade_section
		grade_section_with_academic_year_id(AcademicYear.current_id || AcademicYear.current.id)
	end

	def current_roster_no
		roster_no_with_academic_year_id(AcademicYear.current_id || AcademicYear.current.id)
	end

	def roster_no_with_academic_year_id(academic_year_id)
		grade_sections_students
				.with_academic_year(academic_year_id)
				.pluck(:order_no)
				.first
	end

	def grade_section_with_academic_year_id(academic_year_id)
		GradeSection.joins(:grade_sections_students)
			.where(grade_sections_students: {academic_year_id:academic_year_id, student:self})
			.select('grade_sections.*, grade_sections_students.track as track').take
	end

	def self.having_books_with_condition(condition)
	  ## The following statement, unforetunately, won't work. So we fallback to sql statement.
	  # @students = Student.joins(:student_books)
	  #                   .where(student_books: {end_copy_condition:missing})
	  #                   .order('student_books.grade_section_id' ,'CAST(student_books.roster_no AS int)')
	  #                   .uniq
		Student.find_by_sql [
			"SELECT DISTINCT students.*, student_books.grade_section_id, CAST(student_books.roster_no AS int)
			 FROM students
			 INNER JOIN student_books ON student_books.student_id = students.id
			 WHERE student_books.end_copy_condition_id = ?
			 ORDER BY student_books.grade_section_id, CAST(student_books.roster_no AS int)", condition.id
		]
	end

	def self.in_section_having_books_with_condition(condition, section:)
		Student.find_by_sql [
			"SELECT DISTINCT students.*, student_books.grade_section_id, CAST(student_books.roster_no AS int)
			 FROM students
			 INNER JOIN student_books ON student_books.student_id = students.id
			 WHERE student_books.end_copy_condition_id = ? AND grade_section_id = ?
			 ORDER BY student_books.grade_section_id, CAST(student_books.roster_no AS int)",
			 condition.id, section.id
		]
	end

	def sibs
		FamilyMember.where(family_id:self.family_id, relation:'child').where.not(student_id:self.id).includes(:student).map &:student
	end

	def guardians
		FamilyMember.where(family_id:self.family_id).guardians.includes(:guardian)
	end

	def force_callbacks
		name_will_change!
	end
end
