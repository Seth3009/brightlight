class CreateDoorAccessLogs < ActiveRecord::Migration
  def change
    create_table :door_access_logs do |t|
      t.string :location
      t.string :card
      t.references :employee, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
