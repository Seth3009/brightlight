class AddColumnToSuppliesTransactionItem < ActiveRecord::Migration
  def change
    add_column :supplies_transaction_items, :barcode, :string
  end
end
