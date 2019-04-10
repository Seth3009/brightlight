class AddActualAmtToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :actual_amt, :decimal
  end
end
