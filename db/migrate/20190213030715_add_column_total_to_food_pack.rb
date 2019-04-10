class AddColumnTotalToFoodPack < ActiveRecord::Migration
  def change
    add_column :food_packs, :total, :integer, default:0
  end
end
