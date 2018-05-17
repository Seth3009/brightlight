class AddColumnToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :public_access, :boolean, default:false
  end
end
