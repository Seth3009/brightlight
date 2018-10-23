class AddColumnsToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :subtotal, :decimal
    add_column :purchase_orders, :discounts, :decimal
    add_column :purchase_orders, :est_tax, :decimal
    add_column :purchase_orders, :non_recurring, :decimal
    add_column :purchase_orders, :shipping, :decimal
    add_column :purchase_orders, :down_payment, :decimal
    add_reference :purchase_orders, :buyer, index: true #, foreign_key: true
    add_column :purchase_orders, :instructions, :string
    add_column :purchase_orders, :fob, :string
    add_column :purchase_orders, :method, :string
    add_column :purchase_orders, :delivery, :string
    add_reference :purchase_orders, :term_of_payment, index: true #, foreign_key: true
  end
end
