class ChangeStartTimeAndEndTimeToBeStringInLeaveRequests < ActiveRecord::Migration
  def change
    change_column :leave_requests, :start_time, :string
    change_column :leave_requests, :end_time, :string
  end
end
