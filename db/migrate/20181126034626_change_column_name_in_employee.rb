class ChangeColumnNameInEmployee < ActiveRecord::Migration
  def change
    rename_column :employees, :approver1, :approver_id
    rename_column :employees, :approver2, :approver_assistant_id
  end
end
