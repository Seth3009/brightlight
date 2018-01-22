class CreateItemUnits < ActiveRecord::Migration
  def change
    create_table :item_units do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
