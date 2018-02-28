class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :room_number

      t.timestamps null: false
    end
  end
end
