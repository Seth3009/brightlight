class CreateClassPeriods < ActiveRecord::Migration
  def change
    create_table :class_periods do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.string :school
      t.string :is_break

      t.timestamps null: false
    end
  end
end
