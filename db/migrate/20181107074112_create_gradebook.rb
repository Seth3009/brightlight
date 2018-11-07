class CreateGradebook < ActiveRecord::Migration
  def change
    create_table :gradebook do |t|
      t.string :studentname
      t.string :grade
      t.string :class
      t.decimal:avg
      t.string :semester

      t.timestamps null: false
    end
  end
end
