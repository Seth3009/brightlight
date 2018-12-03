class AddColumnQtyToFoodPackage < ActiveRecord::Migration
  def change
    add_column :food_packages, :qty, :float, default:0
  end
end
