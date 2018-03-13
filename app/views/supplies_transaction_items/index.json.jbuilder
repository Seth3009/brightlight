json.array!(@supplies_transaction_items) do |supplies_transaction_item|
  json.extract! supplies_transaction_item, :id, :supplies_transaction_id, :product_id, :in_out, :qty
  json.url supplies_transaction_item_url(supplies_transaction_item, format: :json)
end
