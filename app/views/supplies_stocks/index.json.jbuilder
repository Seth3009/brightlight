json.array!(@supplies_stocks) do |supplies_stock|
  json.extract! supplies_stock, :id, :trx_date, :trx_type, :qty, :trx_notes, :supply_id, :user_id, :warehouse_id
  json.url supplies_stock_url(supplies_stock, format: :json)
end
