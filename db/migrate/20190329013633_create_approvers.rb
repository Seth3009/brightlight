class CreateApprovers < ActiveRecord::Migration
  def change
    create_table :approvers do |t|
      t.belongs_to :employee, index: true, foreign_key: true
      t.string :category
      t.belongs_to :department, index: true, foreign_key: true
      t.belongs_to :event, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :level
      t.string :type
      t.string :notes
      t.boolean :active

      t.timestamps null: false
    end
  end
end
