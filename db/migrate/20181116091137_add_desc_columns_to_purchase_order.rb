class AddDescColumnsToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :description, :string
    add_column :purchase_orders, :dlvry_address, :string
    add_column :purchase_orders, :dlvry_address2, :string
    add_column :purchase_orders, :dlvry_city, :string
    add_column :purchase_orders, :dlvry_post_code, :string
  end
end
