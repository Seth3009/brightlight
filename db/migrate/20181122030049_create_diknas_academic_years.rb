class CreateDiknasAcademicYears < ActiveRecord::Migration
  def change
    create_table :diknas_academic_years do |t|
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
