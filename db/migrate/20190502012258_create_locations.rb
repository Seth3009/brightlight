class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :code
      t.string :name
      t.string :building
      t.string :purpose
      t.string :notes
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
