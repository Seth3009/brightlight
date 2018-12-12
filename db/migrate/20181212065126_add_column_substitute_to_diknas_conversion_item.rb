class AddColumnSubstituteToDiknasConversionItem < ActiveRecord::Migration
  def change
    add_column :diknas_conversion_items, :substitute, :boolean, default: false
  end
end
