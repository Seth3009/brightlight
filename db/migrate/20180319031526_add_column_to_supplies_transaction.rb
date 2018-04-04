class AddColumnToSuppliesTransaction < ActiveRecord::Migration
  def change
    add_column :supplies_transactions, :card, :string
  end
end
