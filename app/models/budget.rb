class Budget < ActiveRecord::Base
  belongs_to :department
  belongs_to :budget_holder, class_name: 'Employee'
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :approver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many :budget_items, -> { order(:id) }
  
  validates :department_id, presence: true
  validates :academic_year_id, presence: true
  validates :total_amt, presence: true

  accepts_nested_attributes_for :budget_items, reject_if: :all_blank, allow_destroy: true

  scope :current, lambda { where(academic_year: AcademicYear.current) }

  def to_s
    if grade_section
      "#{grade_section.name} - #{academic_year.name}"
    else
      "#{department.name} - #{academic_year.name}"
    end
  end
end
