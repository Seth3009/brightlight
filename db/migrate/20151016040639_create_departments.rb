class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :code
      t.integer :manager

      t.timestamps null: false
    end
  end
end
