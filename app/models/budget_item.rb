class BudgetItem < ActiveRecord::Base
  belongs_to :budget
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  validates :description, presence: true
  validates :amount, presence: true

  def description_with_month_and_year
    "#{description} - #{month}/#{year}"
  end

  def to_s
    "#{description}: #{month}/#{year}"
  end

end
