json.array!(@events) do |event|
  json.extract! event, :id, :name, :department_id, :description, :manager_id, :start_date, :end_date
  json.url event_url(event, format: :json)
end
