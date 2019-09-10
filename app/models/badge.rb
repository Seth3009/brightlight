class Badge < ActiveRecord::Base
  validates :employee_id, :student_id, uniqueness: true, allow_blank: true
  validates :employee_id, presence: true, unless: -> { student_id.present? || !active }
  validates :student_id, presence: true, unless: -> { employee_id.present? || !active }
  validates :code, uniqueness: true

  belongs_to :employee
  belongs_to :student 
  default_scope {where(active: true)}

  scope :with_grade_section, lambda {
    joins(:student)
    .joins('left join grade_sections_students on grade_sections_students.student_id = students.id')
    .where('grade_sections_students.academic_year_id = ?', AcademicYear.current.id)
		.joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
    .joins('left join grade_levels on grade_levels.id = grade_sections.grade_level_id')
		.select('badges.*, grade_sections.id as gs_id, grade_sections.name as gs_name')
  }
  
  scope :by_grade_section, lambda { |grade_section_ids|
    with_grade_section
    .where('grade_sections.id in (?)', [*grade_section_ids])
  }

  filterrific(
    default_filter_params: { sorted_by: 'name' },
    available_filters: [
      :sorted_by,
      :search_query,
      :by_kind,
      :by_grade_section
    ]
  )

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
        "(LOWER(badges.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^name/
			order("LOWER(badges.name) #{ direction }")
		when /^grade_section/
			with_grade_section.order("grade_sections.name #{ direction}, LOWER(students.name) asc")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  # scope :sorted_by, lambda { |sort_option|
  #   # extract the sort direction from the param value.
  #   direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  #   case sort_option.to_s
  #   when /^created_at_/
  #     order("badges.created_at #{ direction }")
  #   when /^name/
  #     order("LOWER(badges.name) #{ direction }")    
  #   else
  #     raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  #   end
  # }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']  
    ]
  end

  scope :by_kind, lambda { |kind|
    where('kind=?', kind)
  }


end
