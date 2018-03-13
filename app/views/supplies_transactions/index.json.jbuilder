json.array!(@supplies_transactions) do |supplies_transaction|
  json.extract! supplies_transaction, :id, :transaction_date, :employee_id, :itemcount
  json.url supplies_transaction_url(supplies_transaction, format: :json)
end
