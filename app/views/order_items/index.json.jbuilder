json.array!(@order_items) do |order_item|
<<<<<<< HEAD
  json.extract! order_item, :id, :purchase_order, :stock_item, :quantity, :unit,, :min_delivery_qty, :pending_qty, :type,, :line_amount, :unit_price, :currency,, :deleted, :description,, :status,, :line_num, :extra1,, :extra2
=======
  json.extract! order_item, :id, :purchase_order_id, :no, :order_date, :supplier, :supplier_id, :req_line_id, :invoice_amt, :dp_amount, :dp_date, :notes
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  json.url order_item_url(order_item, format: :json)
end
