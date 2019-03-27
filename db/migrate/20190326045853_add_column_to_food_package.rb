class AddColumnToFoodPackage < ActiveRecord::Migration
  def change
    add_column :food_packages, :package_unit, :string
  end
end
