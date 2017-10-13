class CreateDeliveryItems < ActiveRecord::Migration
  def change
    create_table :delivery_items do |t|
      t.belongs_to :delivery, index: true
      t.references :order_item, index: true
      t.float :quantity
      t.string :unit
      t.references :accepted_by, references: :users, index: true
      t.date :accepted_date
      t.references :checked_by, references: :users, index: true
      t.string :checked_date
      t.string :notes
      t.boolean :is_accepted
      t.boolean :is_rejected
      t.string :reject_notes
      t.string :accept_notes
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
