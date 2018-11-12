class CreateDiknasGradebooks < ActiveRecord::Migration
  def change
    create_table :diknas_gradebooks do |t|
      t.string :studentname
      t.string :grade
      t.string :class
      t.string :avg
      t.string :semester

      t.timestamps null: false
    end
  end
end
