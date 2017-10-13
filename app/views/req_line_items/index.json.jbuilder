json.array!(@req_items) do |req_item|
  json.extract! req_item, :id, :requisition, :description,, :qty_reqd, :unit,, :est_price, :actual_price, :currency,, :notes,, :qty_ordered, :order_date, :qty_delivered, :delivery_date, :qty_accepted, :acceptance_date, :qty_rejected, :needed_by_date, :acceptance_notes,, :reject_notes
  json.url req_item_url(req_item, format: :json)
end
