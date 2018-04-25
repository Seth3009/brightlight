class ActivitySchedule < ActiveRecord::Base
  has_many :students, through: :student_activities
end
