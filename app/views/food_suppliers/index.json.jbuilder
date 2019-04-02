json.array!(@food_suppliers) do |food_supplier|
  json.extract! food_supplier, :id, :supplier, :address, :contact_person, :phone
  json.url food_supplier_url(food_supplier, format: :json)
end
