class CreateFoodDeliveryItems < ActiveRecord::Migration
  def change
    create_table :food_delivery_items do |t|
      t.references :food_delivery, index: true, foreign_key: true
      t.references :food_package, index: true, foreign_key: true
      t.float :qty

      t.timestamps null: false
    end
  end
end
