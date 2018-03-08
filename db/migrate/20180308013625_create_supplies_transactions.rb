class CreateSuppliesTransactions < ActiveRecord::Migration
  def change
    create_table :supplies_transactions do |t|
      t.datetime :transaction_date
      t.references :employee, index: true, foreign_key: true
      t.integer :itemcount, default: 0

      t.timestamps null: false
    end
  end
end
