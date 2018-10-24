json.array!(@req_items) do |req_item|
  json.extract! req_item, :id, :requisition_id, :description, :qty_reqd, :unit, :est_price, :actual_price, :notes, :needed_by_date, :qty_ordered
  json.url req_item_url(req_item, format: :json)
  json.requester req_item.requisition.requester.name
  json.department req_item.requisition.department.name
end
