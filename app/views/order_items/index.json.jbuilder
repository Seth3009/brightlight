json.array!(@order_items) do |order_item|
  json.extract! order_item, :id, :purchase_order, :stock_item, :quantity, :unit,, :min_delivery_qty, :pending_qty, :type,, :line_amount, :unit_price, :currency,, :deleted, :description,, :status,, :line_num, :extra1,, :extra2
  json.url order_item_url(order_item, format: :json)
end
