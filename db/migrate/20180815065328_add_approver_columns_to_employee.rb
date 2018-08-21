class AddApproverColumnsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :approver1, :integer
    add_column :employees, :approver2, :integer
  end
end
