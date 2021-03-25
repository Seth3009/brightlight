class AddColumnsCreatedAndUpdated < ActiveRecord::Migration
  def change
    add_column :fund_requests, :event_id, :integer
    add_column :fund_requests, :created_by_id, :integer
    add_column :fund_requests, :last_updated_by_id, :integer
    add_column :fund_requests, :department_id, :integer
    add_column :fund_requests, :budget_approver_id, :integer
    add_column :fund_requests, :supervisor_id, :integer
    add_column :fund_requests, :req_approver_id, :integer
    add_column :fund_requests, :sent_to_supv, :date
    add_column :fund_requests, :sent_for_bgt_approval, :date

    add_foreign_key :fund_requests, :departments
    add_foreign_key :fund_requests, :employees, column: :requester_id
    add_foreign_key :fund_requests, :employees, column: :supervisor_id
    add_foreign_key :fund_requests, :employees, column: :req_approver_id
    add_foreign_key :fund_requests, :employees, column: :budget_approver_id
    add_foreign_key :fund_requests, :users, column: :created_by_id
    add_foreign_key :fund_requests, :users, column: :last_updated_by_id
  end
end
