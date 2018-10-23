class CreatePoReqs < ActiveRecord::Migration
  def change
    create_table :po_reqs do |t|
      t.references :purchase_order, index: true, foreign_key: true
      t.references :requisition, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
