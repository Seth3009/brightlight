json.array!(@lunch_menus) do |lunch_menu|
  json.extract! lunch_menu, :id, :lunch_date, :food_id, :adj_g1, :adj_g4, :adj_sol, :adj_sor, :adj_adult, :total_adj, :academic_year_id
  json.url lunch_menu_url(lunch_menu, format: :json)
end
