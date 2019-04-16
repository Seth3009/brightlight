class AddDateToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :sign_date, :date
  end
end
