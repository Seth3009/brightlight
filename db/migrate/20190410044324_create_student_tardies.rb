class CreateStudentTardies < ActiveRecord::Migration
  def change
    create_table :student_tardies do |t|
      t.references :student, index: true, foreign_key: true
      t.string :grade
      t.string :reason
      t.references :employee, index: true, foreign_key: true
      t.references :academic_year, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
