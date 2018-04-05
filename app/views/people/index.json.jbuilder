json.array!(@people) do |person|
  json.extract! person, :id, :full_name, :first_name, :last_name, :nick_name, :date_of_birth, :place_of_birth, :gender
  json.url person_url(person, format: :json)
end
