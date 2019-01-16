json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :food_id, :raw_food_id, :recipe_portion, :qty, :custom_size, :size_divider, :portion_size, :gr1_portion, :gr2_portion, :sol_portion, :sor_portion, :adult_portion
  json.url recipe_url(recipe, format: :json)
end
