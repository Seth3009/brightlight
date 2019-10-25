class AddColumnsInReceiveItem < ActiveRecord::Migration
  def change
    add_column :receive_items, :location, :string
    add_column :receive_items, :code, :string
  end
end
