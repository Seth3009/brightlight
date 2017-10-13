json.array!(@delivery_items) do |delivery_item|
  json.extract! delivery_item, :id, :delivery, :order_item, :quantity, :unit,, :accepted_by, :accepted_date, :checked_by, :checked_date,, :notes,, :is_accepted, :is_rejected, :reject_notes,, :accept_notes
  json.url delivery_item_url(delivery_item, format: :json)
end
