class ChangeColumnsInProducts < ActiveRecord::Migration
  def change
    remove_column :products, :title
    remove_column :products, :description
    remove_column :products, :image_url
    remove_column :products, :price
    add_column :products, :is_canceled, :boolean, default: false
    add_column :products, :code, :string 
    add_column :products, :name, :string 
    add_column :products, :price, :decimal , default: 0
    add_column :products, :min_stock, :float , default: 0.0
    add_column :products, :max_stock, :float , default: 100.0
    add_column :products, :stock_type, :string 
    add_reference :products, :item_unit, index: true
    add_reference :products, :item_category, index: true
    add_column :products, :is_active, :boolean , default: true
    add_column :products, :img_url, :string 
  end
end
