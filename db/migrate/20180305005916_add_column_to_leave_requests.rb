class AddColumnToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :is_canceled, :boolean, default: false
  end
end
