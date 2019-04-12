class StudentTardy < ActiveRecord::Base
  belongs_to :student
  belongs_to :employee
  belongs_to :academic_year
  belongs_to :grade_section

  validates :student, presence: true
  validates :employee, presence: true
  validates :academic_year, presence: true
  validates :reason, presence: true
  validates :grade_section, presence: true
end
