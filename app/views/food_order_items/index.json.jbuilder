json.array!(@food_order_items) do |food_order_item|
  json.extract! food_order_item, :id, :food_order_id, :food_package_id, :qty_order, :qty_received
  json.url food_order_item_url(food_order_item, format: :json)
end
