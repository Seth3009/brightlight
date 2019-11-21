class CreateReceiveItems < ActiveRecord::Migration
  def change
    create_table :receive_items do |t|
      t.belongs_to :purchase_receive, index: true, foreign_key: true
      t.belongs_to :order_item, index: true, foreign_key: true
      t.float :quantity
      t.string :unit
      t.boolean :partial
      t.float :qty_accepted
      t.float :qty_rejected
      t.string :notes

      t.timestamps null: false
    end
  end
end
