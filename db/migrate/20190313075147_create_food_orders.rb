class CreateFoodOrders < ActiveRecord::Migration
  def change
    create_table :food_orders do |t|
      t.date :date_order
      t.string :order_notes
      t.references :food_supplier, index: true, foreign_key: true
      t.boolean :is_completed

      t.timestamps null: false
    end
  end
end
