class NatExam < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :academic_year
  belongs_to :diknas_course

  scope :for_academic_year, lambda { | year | where(academic_year_id: year) }

  def students(academic_year:)
    Student.where id: NatExam.for_academic_year(year).pluck(:student_id)
  end

end
