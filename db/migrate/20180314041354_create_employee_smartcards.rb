class CreateEmployeeSmartcards < ActiveRecord::Migration
  def change
    create_table :employee_smartcards do |t|
      t.string :card
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
