class AddDefaultValueToActivitySchedule < ActiveRecord::Migration
  def change        
    change_column :activity_schedules, :sun_start, :time, default: "00:00:00"
    change_column :activity_schedules, :sun_end, :time, default: "00:00:00"
    change_column :activity_schedules, :mon_start, :time, default: "00:00:00"
    change_column :activity_schedules, :mon_end, :time, default: "00:00:00"
    change_column :activity_schedules, :tue_start, :time, default: "00:00:00"
    change_column :activity_schedules, :tue_end, :time, default: "00:00:00"
    change_column :activity_schedules, :wed_start, :time, default: "00:00:00"
    change_column :activity_schedules, :wed_end, :time, default: "00:00:00"
    change_column :activity_schedules, :thu_start, :time, default: "00:00:00"
    change_column :activity_schedules, :thu_end, :time, default: "00:00:00"
    change_column :activity_schedules, :fri_start, :time, default: "00:00:00"
    change_column :activity_schedules, :fri_end, :time, default: "00:00:00"
    change_column :activity_schedules, :sat_start, :time, default: "00:00:00"
    change_column :activity_schedules, :sat_end, :time, default: "00:00:00"    
  end
end
