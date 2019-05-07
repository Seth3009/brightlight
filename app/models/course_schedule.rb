class CourseSchedule < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_section
  belongs_to :class_period
  belongs_to :room
  belongs_to :academic_term
end
