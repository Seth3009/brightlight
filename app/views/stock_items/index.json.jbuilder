json.array!(@stock_items) do |stock_item|
  json.extract! stock_item, :id, :name,, :code,, :description,, :tags,, :short_desc,, :is_active, :unit_price, :image, :stock_category, :class,, :group,, :weight,, :extra1,, :extra2
  json.url stock_item_url(stock_item, format: :json)
end
