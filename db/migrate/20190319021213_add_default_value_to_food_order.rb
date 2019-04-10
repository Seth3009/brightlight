class AddDefaultValueToFoodOrder < ActiveRecord::Migration
  def up
    change_column :food_orders, :is_completed, :boolean, default: false
  end

  def down
    change_column :food_orders, :is_completed, :boolean, default: nil
  end
end
