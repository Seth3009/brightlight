class Batch < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_section
  belongs_to :academic_year
  belongs_to :academic_term
end
