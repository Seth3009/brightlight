class AddColumnToFoodSupplier < ActiveRecord::Migration
  def change
    add_column :food_suppliers, :is_active, :boolean, default: true
  end
end
