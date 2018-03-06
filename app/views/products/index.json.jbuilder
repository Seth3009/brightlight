json.array!(@products) do |product|
  json.extract! product, :id, :code, :name, :price, :min_stock, :max_stock, :stock_type, :item_unit_id, :item_category_id, :is_active, :img_url
  json.url product_url(product, format: :json)
end
