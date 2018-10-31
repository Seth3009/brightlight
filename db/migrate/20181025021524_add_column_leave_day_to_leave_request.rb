class AddColumnLeaveDayToLeaveRequest < ActiveRecord::Migration
  def change
    add_column :leave_requests, :leave_day, :integer, default: 0
  end
end
