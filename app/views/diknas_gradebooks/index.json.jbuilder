json.array!(@diknas_gradebooks) do |diknas_gradebook|
  json.extract! diknas_gradebook, :id, :studentname, :grade, :class, :avg, :semester
  json.url diknas_gradebook_url(diknas_gradebook, format: :json)
end
