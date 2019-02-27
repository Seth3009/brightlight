json.array!(@class_periods) do |class_period|
  json.extract! class_period, :id, :name, :start_time, :end_time, :school, :is_break
  json.url class_period_url(class_period, format: :json)
end
