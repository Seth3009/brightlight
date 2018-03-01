class CreateSuppliesStocks < ActiveRecord::Migration
  def change
    create_table :supplies_stocks do |t|
      t.date :trx_date
      t.string :trx_type
      t.float :qty
      t.string :trx_notes
      t.references :supply, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :warehouse, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
