class CreateDiknasCourses < ActiveRecord::Migration
  def change
    create_table :diknas_courses do |t|
      t.string :number
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
