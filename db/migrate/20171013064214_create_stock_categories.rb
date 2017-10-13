class CreateStockCategories < ActiveRecord::Migration
  def change
    create_table :stock_categories do |t|
      t.string :name
      t.string :code
      t.string :description
      t.string :type
      t.boolean :is_active
      t.string :location

      t.timestamps null: false
    end
  end
end
