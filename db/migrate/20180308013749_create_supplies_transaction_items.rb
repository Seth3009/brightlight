class CreateSuppliesTransactionItems < ActiveRecord::Migration
  def change
    create_table :supplies_transaction_items do |t|
      t.references :supplies_transaction, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.string :in_out, default: "OUT"
      t.float :qty

      t.timestamps null: false
    end
  end
end
