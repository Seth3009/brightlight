class AddColumnsToCourseSection < ActiveRecord::Migration
  def change
    add_reference :course_sections, :instructor2, index: true
    add_reference :course_sections, :aide, index: true
    add_column :course_sections, :sem1, :boolean
    add_column :course_sections, :sem2, :boolean
    add_reference :course_sections, :location, index: true, foreign_key: true
  end
end
