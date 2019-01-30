class ChangeColumnDefaultInOrderItems < ActiveRecord::Migration
  def change
    change_column_default :order_items, :quantity, 0.0
    change_column_default :order_items, :line_amount, 0.0
    change_column_default :order_items, :unit_price, 0.0
    change_column_default :order_items, :discount, 0.0
    change_column_default :order_items, :est_tax, 0.0
    change_column_default :order_items, :non_recurring, 0.0
    change_column_default :order_items, :shipping, 0.0
    change_column_default :order_items, :down_payment, 0.0 
    change_column_default :order_items, :min_delivery_qty, 0.0 
    change_column_default :order_items, :pending_qty, 0.0 
    change_column_default :order_items, :deleted, false
  end
end
