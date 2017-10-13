class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references, :purchase_order
      t.references, :stock_item
      t.float, :quantity
      t.string :unit,
      t.float, :min_delivery_qty
      t.float, :pending_qty
      t.string :type,
      t.decimal, :line_amount
      t.decimal, :unit_price
      t.string :currency,
      t.boolean, :deleted
      t.string :description,
      t.string :status,
      t.integer, :line_num
      t.string :extra1,
      t.string :extra2
      t.created_by: references
      t.last_updated_by: references
      
      t.timestamps null: false
    end
  end
end
