class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :order_num
      t.references :department
      t.references :requestor, references: :employees, index: true
      t.references :approver, references: :employees, index: true
      t.date :order_date
      t.date :due_date
      t.decimal :total_amount
      t.boolean :is_active
      t.string :currency
      t.boolean :deleted
      t.string :notes
      t.string :appvl_notes
      t.date :completed_date
      t.references :supplier
      t.string :contact
      t.string :phone_contact
      t.string :status
      t.string :extra1
      t.string :extra2
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
