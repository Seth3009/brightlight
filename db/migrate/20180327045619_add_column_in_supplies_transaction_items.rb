class AddColumnInSuppliesTransactionItems < ActiveRecord::Migration
  def change
    add_reference :supplies_transaction_items, :item_unit, foreign_key: true
    add_reference :supplies_transaction_items, :item_category, foreign_key: true
    add_column :supplies_transaction_items, :price, :decimal
  end
end
