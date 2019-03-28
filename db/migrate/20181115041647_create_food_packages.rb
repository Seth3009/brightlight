class CreateFoodPackages < ActiveRecord::Migration
  def change
    create_table :food_packages do |t|
      t.string :packaging
      t.float :qty
      t.string :unit
      t.references :raw_food, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
