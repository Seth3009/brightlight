class RenameColumnsInOrderItem < ActiveRecord::Migration
  def change
    rename_column :order_items, :extra1, :remark
    rename_column :order_items, :extra2, :notes
  end
end
