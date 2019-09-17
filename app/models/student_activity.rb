class StudentActivity < ActiveRecord::Base
  belongs_to :student  
  belongs_to :activity_schedule
  belongs_to :academic_year

  validates :student, presence: true
  validates :academic_year, presence: true
  validates :activity_schedule, presence: true  
  validates :student, uniqueness: {:scope => [:academic_year_id, :activity_schedule_id]}


  scope :student_query, lambda {
    joins('left join students on students.id = student_activities.student_id')
    .joins('left join grade_sections_students on grade_sections_students.student_id = students.id')
    .joins('left join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
    .where('grade_sections_students.academic_year_id = student_activities.academic_year_id')
    .select('students.name, grade_sections.id as gs_id, grade_sections.name as grade')
  }
end
