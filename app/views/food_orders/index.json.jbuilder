json.array!(@food_orders) do |food_order|
  json.extract! food_order, :id, :date_order, :order_notes, :food_supplier_id, :is_completed
  json.url food_order_url(food_order, format: :json)
end
