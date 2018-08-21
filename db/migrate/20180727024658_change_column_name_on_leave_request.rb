class ChangeColumnNameOnLeaveRequest < ActiveRecord::Migration
  def change
    rename_column :leave_requests, :leave_attachment, :hr_staf_notes
  end
end
