class Badge < ActiveRecord::Base
  validates :employee_id, :student_id, uniqueness: true, allow_blank: true
  validates :employee_id, presence: {unless: :student_id?}
  validates :student_id, presence: {unless: :employee_id?}
  validates :code, uniqueness: true

  belongs_to :employee
  belongs_to :student 
end
