json.array!(@employee_smartcards) do |employee_smartcard|
  json.extract! employee_smartcard, :id, :card, :employee_id
  json.url employee_smartcard_url(employee_smartcard, format: :json)
end
