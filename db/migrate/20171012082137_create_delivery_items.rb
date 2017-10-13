class CreateDeliveryItems < ActiveRecord::Migration
  def change
    create_table :delivery_items do |t|
      t.references, :delivery
      t.references, :order_item
      t.float, :quantity
      t.string :unit,
      t.references, :accepted_by
      t.date, :accepted_date
      t.references, :checked_by
      t.string :checked_date,
      t.string :notes,
      t.boolean, :is_accepted
      t.boolean, :is_rejected
      t.string :reject_notes,
      t.string :accept_notes
      t.created_by: references
      t.last_updated_by: references
      
      t.timestamps null: false
    end
  end
end
