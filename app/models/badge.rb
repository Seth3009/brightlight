class Badge < ActiveRecord::Base
  validates :employee_id, :student_id, uniqueness: true, allow_blank: true
  validates :employee_id, presence: true, unless: -> { student_id.present? || !active }
  validates :student_id, presence: true, unless: -> { employee_id.present? || !active }
  validates :code, uniqueness: true

  belongs_to :employee
  belongs_to :student 
  default_scope {where(active: true)}

  filterrific(
    default_filter_params: { sorted_by: 'name' },
    available_filters: [
      :sorted_by,
      :search_query,
      :filtered_by
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
    when /^created_at_/
      order("badges.created_at #{ direction }")
    when /^name/
      order("LOWER(badges.name) #{ direction }")    
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']     
    ]
  end

  scope :filtered_by, lambda { |filter_option|
    where('kind=?', filter_option)
  }

end
