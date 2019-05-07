class CreateCourseSchedules < ActiveRecord::Migration
  def change
    create_table :course_schedules do |t|
      t.belongs_to :course, index: true, foreign_key: true
      t.belongs_to :course_section, index: true, foreign_key: true
      t.belongs_to :class_period, index: true, foreign_key: true
      t.belongs_to :room, index: true, foreign_key: true
      t.boolean :active
      t.belongs_to :academic_term, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
