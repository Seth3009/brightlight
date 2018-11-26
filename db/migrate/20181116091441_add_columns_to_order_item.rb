class AddColumnsToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :code, :string
  end
end
