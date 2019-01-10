class CreateFoodPacks < ActiveRecord::Migration
  def change
    create_table :food_packs do |t|
      t.integer :g1
      t.integer :g2
      t.integer :g3
      t.integer :g4
      t.integer :g5
      t.integer :g6
      t.integer :g7
      t.integer :g8
      t.integer :g9
      t.integer :g10
      t.integer :g11
      t.integer :g12
      t.integer :employee
      t.references :academic_year, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
