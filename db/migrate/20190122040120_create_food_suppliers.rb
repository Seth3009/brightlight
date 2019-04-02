class CreateFoodSuppliers < ActiveRecord::Migration
  def change
    create_table :food_suppliers do |t|
      t.string :supplier
      t.string :address
      t.string :contact_person
      t.string :phone

      t.timestamps null: false
    end
  end
end
