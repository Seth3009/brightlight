class AddColumnToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :vice_manager_id, :integer
  end
end
