class CreateFoodPackagesFoodSuppliers < ActiveRecord::Migration
  def change
    create_table :food_packages_food_suppliers do |t|
      t.references :food_package, index: true, foreign_key: true
      t.references :food_supplier, index: true, foreign_key: true
      t.float :price
      t.date :date_update

      t.timestamps null: false
    end
  end
end
