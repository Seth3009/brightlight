json.array!(@purchase_receives) do |purchase_receive|
  json.extract! purchase_receive, :id, :purchase_order_id, :date_received, :date_checked, :receiver_id, :checker_id, :notes, :partial, :status
  json.url purchase_receive_url(purchase_receive, format: :json)
end
