json.array!(@food_delivery_items) do |food_delivery_item|
  json.extract! food_delivery_item, :id, :food_delivery_id, :food_package_id, :qty
  json.url food_delivery_item_url(food_delivery_item, format: :json)
end
