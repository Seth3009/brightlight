class RoomAccess < ActiveRecord::Base
  belongs_to :room
  belongs_to :badge

  validates :badge, uniqueness: {:scope => [:room]}

  scope :with_student_and_current_grade_section, lambda {
    joins(:badge)
    .joins('left join students on students.id = badges.student_id')
    .joins('left join grade_sections_students gss on gss.student_id = badges.student_id')
		.where('gss.academic_year_id = ?', AcademicYear.current_id || AcademicYear.current.id)
    .joins('left join grade_sections gs on gs.id = gss.grade_section_id')
    .select('room_accesses.*, badges.*, gs.name as gs_name')
  }
end
