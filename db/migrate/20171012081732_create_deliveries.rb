class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references :purchase_order, index: true
      t.date :delivery_date
      t.string :address
      t.references :accepted_by, references: :employees, index: true
      t.date :accepted_date
      t.references :checked_by, references: :employees, index: true
      t.date :checked_date
      t.string :notes
      t.string :delivery_method
      t.string :status
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
