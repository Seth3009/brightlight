class DiknasConversion < ActiveRecord::Base
  belongs_to :course
  belongs_to :diknas_course
  belongs_to :academic_year
  belongs_to :academic_term
end
