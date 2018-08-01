class AddColumnToLeaveRequest < ActiveRecord::Migration
  def change
    add_column :leave_requests, :category, :string
  end
end
