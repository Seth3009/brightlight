class AddColumnEmployeeCanceledToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :employee_canceled, :boolean, default:false
  end
end
