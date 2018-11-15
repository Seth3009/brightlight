json.array!(@food_packages) do |food_package|
  json.extract! food_package, :id, :packaging, :qty, :unit
  json.url food_package_url(food_package, format: :json)
end
