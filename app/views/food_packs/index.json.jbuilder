json.array!(@food_packs) do |food_pack|
  json.extract! food_pack, :id, :g1, :g2, :g3, :g4, :g5, :g6, :g7, :g8, :g9, :g10, :g11, :g12, :employee, :academic_year_id
  json.url food_pack_url(food_pack, format: :json)
end
