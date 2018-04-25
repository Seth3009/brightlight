class AddColumnToActivitySchedule < ActiveRecord::Migration
  def change
    add_reference :activity_schedules, :academic_year, index: true, foreign_key: true
  end
end
