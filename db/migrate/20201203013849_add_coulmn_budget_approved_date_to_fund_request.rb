class AddCoulmnBudgetApprovedDateToFundRequest < ActiveRecord::Migration
  def change
    add_column :fund_requests, :budget_approved_date, :date
    add_column :fund_requests, :total_expense, :decimal
  end
end
