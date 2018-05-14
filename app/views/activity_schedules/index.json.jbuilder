json.array!(@activity_schedules) do |activity_schedule|
  json.extract! activity_schedule, :id, :activity, :start_date, :end_date, :sun_start, :sun_end, :mon_start, :mon_end, :tue_start, :tue_end, :wed_start, :wed_end, :thu_start, :thu_end, :fri_start, :fri_end, :sat_start, :sat_end, :is_active
  json.url activity_schedule_url(activity_schedule, format: :json)
end
