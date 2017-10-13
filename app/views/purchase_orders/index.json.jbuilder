json.array!(@purchase_orders) do |purchase_order|
  json.extract! purchase_order, :id, :order_num, :requestor, :order_date, :due_date, :total_amount, :is_active, :currency, :deleted, :notes, :completed_date, :supplier, :contact, :phone_contact,, :user, :status
  json.url purchase_order_url(purchase_order, format: :json)
end
