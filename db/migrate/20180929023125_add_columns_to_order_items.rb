class AddColumnsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :discount, :decimal
    add_column :order_items, :est_tax, :decimal
    add_column :order_items, :non_recurring, :decimal
    add_column :order_items, :shipping, :decimal
    add_column :order_items, :down_payment, :decimal
  end
end
