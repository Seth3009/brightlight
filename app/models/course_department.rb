class CourseDepartment < ActiveRecord::Base
  validates :name, presence: true
end