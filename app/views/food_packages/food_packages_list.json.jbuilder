json.array!(@food_packages) do |food_package|
  json.extract! food_package, :id, :packaging, :package_contents, :unit, :raw_food_id
  json.food_name food_package.raw_food.try(:name)
  # json.unit product.item_unit.try(:abbreviation)
  json.url food_package_url(food_package, format: :json)
end
