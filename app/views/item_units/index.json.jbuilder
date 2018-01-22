json.array!(@item_units) do |item_unit|
  json.extract! item_unit, :id, :name
  json.url item_unit_url(item_unit, format: :json)
end
