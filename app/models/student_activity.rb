class StudentActivity < ActiveRecord::Base
  belongs_to :student
  belongs_to :activity_schedule

  validates :student, presence: true
  validates :activity_schedule, presence: true


  scope :student_query, lambda {
    joins('left join students on students.id = student_activities.student_id')
    .joins('left join grade_sections_students on grade_sections_students.student_id = students.id')
    .joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
    .select('students.name,grade_sections.name as grade')
  }
end
