class CreateFoodDeliveries < ActiveRecord::Migration
  def change
    create_table :food_deliveries do |t|
      t.date :delivery_date
      t.string :deliver_to
      t.string :notes

      t.timestamps null: false
    end
  end
end
