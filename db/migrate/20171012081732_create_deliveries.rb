class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references, :purchase_order
      t.date, :delivery_date
      t.string :address,
      t.references, :accepted_by
      t.date, :accepted_date
      t.references, :checked_by
      t.date, :checked_date
      t.string :notes,
      t.string :delivery_method,
      t.string :status
      t.created_by: references
      t.last_updated_by: references
      
      t.timestamps null: false
    end
  end
end
