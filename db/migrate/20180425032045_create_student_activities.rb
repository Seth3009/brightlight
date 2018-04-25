class CreateStudentActivities < ActiveRecord::Migration
  def change
    create_table :student_activities do |t|
      t.references :student, index: true, foreign_key: true
      t.references :activity_schedule, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
