class BudgetItem < ActiveRecord::Base
  belongs_to :budget
  belongs_to :academic_year
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  validates :budget_id, presence: true
  validates :academic_year_id, presence: true
  validates :description, presence: true
  validates :amount, presence: true

  scope :current, lambda { where(academic_year: AcademicYear.current) }

  before_validation :ensure_academic_year_has_a_value

  def description_with_month_and_year
    "#{description} - #{month}/#{budget.academic_year.name}"
  end

  def to_s
    "#{description}: #{month}/#{academic_year.name}"
  end

  protected
  
  def ensure_academic_year_has_a_value
    self.academic_year_id = budget.academic_year_id unless budget.academic_year_id.blank?
  end 
end
