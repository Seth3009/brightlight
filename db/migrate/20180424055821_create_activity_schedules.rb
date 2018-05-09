class CreateActivitySchedules < ActiveRecord::Migration
  def change
    create_table :activity_schedules do |t|
      t.string :activity
      t.date :start_date
      t.date :end_date
      t.time :sun_start
      t.time :sun_end
      t.time :mon_start
      t.time :mon_end
      t.time :tue_start
      t.time :tue_end
      t.time :wed_start
      t.time :wed_end
      t.time :thu_start
      t.time :thu_end
      t.time :fri_start
      t.time :fri_end
      t.time :sat_start
      t.time :sat_end
      t.boolean :is_active, default:true

      t.timestamps null: false
    end
  end
end
