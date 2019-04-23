class AddActiveColumnToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :active, :boolean, default: true
  end
end
