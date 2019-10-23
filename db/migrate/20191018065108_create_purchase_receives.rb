class CreatePurchaseReceives < ActiveRecord::Migration
  def change
    create_table :purchase_receives do |t|
      t.belongs_to :purchase_order, index: true, foreign_key: true
      t.date :date_received
      t.date :date_checked
      t.belongs_to :receiver
      t.belongs_to :checker
      t.string :notes
      t.boolean :partial
      t.string :status

      t.timestamps null: false
    end
  end
end
