class CreatePoStatuses < ActiveRecord::Migration
  def change
    create_table :po_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
