json.array!(@stock_categories) do |stock_category|
  json.extract! stock_category, :id, :name,, :code,, :description,, :type,, :is_active, :location
  json.url stock_category_url(stock_category, format: :json)
end
