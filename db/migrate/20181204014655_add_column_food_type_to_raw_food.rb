class AddColumnFoodTypeToRawFood < ActiveRecord::Migration
  def change
    add_column :raw_foods, :food_type, :string, default:"-"
  end
end
