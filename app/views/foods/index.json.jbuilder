json.array!(@foods) do |food|
  json.extract! food, :id, :name, :ingredients, :is_active
  json.url food_url(food, format: :json)
end
