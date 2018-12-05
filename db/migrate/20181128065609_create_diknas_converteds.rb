class CreateDiknasConverteds < ActiveRecord::Migration
  def change
    create_table :diknas_converteds do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :academic_year, index: true, foreign_key: true
      t.belongs_to :academic_term, index: true, foreign_key: true
      t.belongs_to :grade_level, index: true, foreign_key: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
