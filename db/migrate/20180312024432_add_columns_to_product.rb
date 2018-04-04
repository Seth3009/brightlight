class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :packs, :float
    add_column :products, :packs_unit, :string
  end
end
