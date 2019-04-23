class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.string :approvable_type
      t.integer :approvable_id
      t.integer :level
      t.belongs_to :approver, index: true, foreign_key: true
      t.boolean :approve
      t.string :notes

      t.timestamps null: false
    end
  end
end
