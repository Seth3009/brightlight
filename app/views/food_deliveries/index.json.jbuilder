json.array!(@food_deliveries) do |food_delivery|
  json.extract! food_delivery, :id, :delivery_date, :deliver_to, :notes
  json.url food_delivery_url(food_delivery, format: :json)
end
