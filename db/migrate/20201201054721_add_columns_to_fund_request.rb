class AddColumnsToFundRequest < ActiveRecord::Migration
  def change
    add_column :fund_requests, :account_id, :integer
    add_column :fund_requests, :budget_type, :string
    add_column :fund_requests, :class_budget_id, :integer
    add_column :fund_requests, :supv_approved_date, :date
  end
end
