class DropSupplies < ActiveRecord::Migration
  def change
    drop_table :supplies
  end
end
