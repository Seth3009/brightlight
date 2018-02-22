json.array!(@supplies) do |supply|
  json.extract! supply, :id, :code, :name, :price, :min_stock, :max_stock, :stock_type, :item_unit_id, :item_category_id, :supply_status
  json.url supply_url(supply, format: :json)
end
