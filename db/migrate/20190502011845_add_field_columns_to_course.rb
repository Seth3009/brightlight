class AddFieldColumnsToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :course_department, index: true, foreign_key: true
    add_column :courses, :level, :string
  end
end
