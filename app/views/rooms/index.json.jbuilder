json.array!(@rooms) do |room|
  json.extract! room, :id, :room_code, :room_name, :location, :ip_address
  json.url room_url(room, format: :json)
end
