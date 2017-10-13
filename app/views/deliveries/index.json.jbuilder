json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :purchase_order, :delivery_date, :address,, :accepted_by, :accepted_date, :checked_by, :checked_date, :notes,, :method,, :status
  json.url delivery_url(delivery, format: :json)
end
