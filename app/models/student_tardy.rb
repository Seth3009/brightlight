class StudentTardy < ActiveRecord::Base
  belongs_to :student
  belongs_to :employee
  belongs_to :academic_year

  validates :student, presence: true
  validates :employee, presence: true
  validates :academic_year, presence: true
  validates :reason, presence: true
  validates :grade, presence: true
end
