class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
