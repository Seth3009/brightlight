class ChangeColumnNameQtyToPackageContent < ActiveRecord::Migration
  def change
    rename_column :food_packages, :qty, :package_contents
  end
end
