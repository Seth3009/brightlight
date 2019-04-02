class CreateRawFoods < ActiveRecord::Migration
  def change
    create_table :raw_foods do |t|
      t.string :name
      t.boolean :is_stock

      t.timestamps null: false
    end
  end
end
