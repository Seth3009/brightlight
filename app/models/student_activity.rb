class StudentActivity < ActiveRecord::Base
  belongs_to :student
  belongs_to :activity_schedule

  validates :student, presence: true
  validates :activity_schedule, presence: true
end
