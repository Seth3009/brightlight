class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :order_num,
      t.references, :requestor, references: users, index: true
      t.date, :order_date
      t.date, :due_date
      t.decimal, :total_amount
      t.boolean, :is_active
      t.string :currency,
      t.boolean, :deleted
      t.string :notes,
      t.date, :completed_date
      t.references, :supplier
      t.string :contact,
      t.string :phone_contact,
      t.references, :user
      t.string :status
      t.references :created_by, references: users, index: true
      t.references :last_updated_by, references: users, index: true

      t.timestamps null: false
    end
    
    add_foreign_key :purchase_orders, :users, column: :requestor_id
    add_foreign_key :purchase_orders, :users, column: :created_by
    add_foreign_key :purchase_orders, :users, column: :last_updated_by
  end
end
