json.array!(@req_line_items) do |req_line_item|
  json.extract! req_line_item, :id, :requisition, :description,, :qty_reqd, :unit,, :est_price, :actual_price, :currency,, :notes,, :qty_ordered, :order_date, :qty_delivered, :delivery_date, :qty_accepted, :acceptance_date, :qty_rejected, :needed_by_date, :acceptance_notes,, :reject_notes
  json.url req_line_item_url(req_line_item, format: :json)
end
