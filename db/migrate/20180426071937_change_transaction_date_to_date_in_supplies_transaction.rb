class ChangeTransactionDateToDateInSuppliesTransaction < ActiveRecord::Migration
  def change
    change_column :supplies_transactions, :transaction_date, :date
  end
end
