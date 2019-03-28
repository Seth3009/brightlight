class CreateFoodOrderItems < ActiveRecord::Migration
  def change
    create_table :food_order_items do |t|
      t.references :food_order, index: true, foreign_key: true
      t.references :food_package, index: true, foreign_key: true
      t.float :qty_order
      t.float :qty_received

      t.timestamps null: false
    end
  end
end
