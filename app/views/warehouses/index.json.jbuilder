json.array!(@warehouses) do |warehouse|
  json.extract! warehouse, :id, :name, :room_number
  json.url warehouse_url(warehouse, format: :json)
end
