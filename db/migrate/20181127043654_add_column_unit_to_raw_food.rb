class AddColumnUnitToRawFood < ActiveRecord::Migration
  def change
    add_column :raw_foods, :unit, :string
  end
end
