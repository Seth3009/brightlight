class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :code
      t.string :name
      t.decimal :price, default: 0
      t.float :min_stock, default: 0.0
      t.float :max_stock, default: 100.0
      t.string :stock_type
      t.references :item_unit, index: true, foreign_key: true
      t.references :item_category, index: true, foreign_key: true
      t.boolean :supply_status, default: true

      t.timestamps null: false
    end
  end
end
