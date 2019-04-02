class AddColumnStockToRawFood < ActiveRecord::Migration
  def change
    add_column :raw_foods, :stock, :float, default:0
  end
end
