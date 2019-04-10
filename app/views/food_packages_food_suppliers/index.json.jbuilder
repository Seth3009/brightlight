json.array!(@food_packages_food_suppliers) do |food_packages_food_supplier|
  json.extract! food_packages_food_supplier, :id, :food_package_id, :food_supplier_id, :price, :date_update
  json.url food_packages_food_supplier_url(food_packages_food_supplier, format: :json)
end
