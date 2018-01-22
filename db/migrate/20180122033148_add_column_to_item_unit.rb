class AddColumnToItemUnit < ActiveRecord::Migration
  def change
    add_column :item_units, :abbreviation, :string
  end
end
