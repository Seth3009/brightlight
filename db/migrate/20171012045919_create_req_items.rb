class CreateReqItems < ActiveRecord::Migration
  def change
    create_table :req_items do |t|
      t.belongs_to :requisition, index: true
      t.string :description
      t.float :qty_reqd
      t.string :unit
      t.decimal :est_price
      t.decimal :actual_price
      t.string :currency
      t.string :notes
      t.float :qty_ordered
      t.date :order_date
      t.float :qty_delivered
      t.date :delivery_date
      t.float :qty_accepted
      t.date :acceptance_date
      t.float :qty_rejected
      t.date :needed_by_date
      t.string :acceptance_notes
      t.string :reject_notes
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
