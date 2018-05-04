class AddColumnToStudentActivity < ActiveRecord::Migration
  def change
    add_reference :student_activities, :academic_year, index: true, foreign_key: true
  end
end
