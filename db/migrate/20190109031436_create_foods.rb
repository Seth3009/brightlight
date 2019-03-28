class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :ingredients, default: 0
      t.boolean :is_active, default: true

      t.timestamps null: false
    end
  end
end
