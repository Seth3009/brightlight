class AddColumnIsActiveToFoodPackage < ActiveRecord::Migration
  def change
    add_column :food_packages, :is_active, :boolean, default:true
  end
end
