json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :first_name, :last_name
end