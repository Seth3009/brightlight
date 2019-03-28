class AddColumnToRawFood < ActiveRecord::Migration
  def change
    add_column :raw_foods, :is_active, :boolean, default: true
  end
end
