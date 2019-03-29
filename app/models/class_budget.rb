class ClassBudget < ActiveRecord::Base
  belongs_to :department
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :holder
end
