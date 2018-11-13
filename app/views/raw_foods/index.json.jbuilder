json.array!(@raw_foods) do |raw_food|
  json.extract! raw_food, :id, :name, :is_stock
  json.url raw_food_url(raw_food, format: :json)
end
