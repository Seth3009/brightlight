class DiknasReportConverted < ActiveRecord::Base
  belongs_to :student
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level
end
