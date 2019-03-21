json.array!(@food_packages) do |food_package|
  json.extract! food_package, :unit_food, :id, :packaging, :package_contents, :unit, :raw_food_id
  json.food_name food_package.raw_food.try(:name)
  json.food_unit food_package.raw_food.try(:unit)
  json.url food_package_url(food_package, format: :json)
end
