class CreateStockItems < ActiveRecord::Migration
  def change
    create_table :stock_items do |t|
      t.string :name
      t.string :code
      t.string :description
      t.string :tags
      t.string :short_desc
      t.boolean :is_active
      t.decimal :unit_price
      t.binary :image, limit: 2.megabyte
      t.references :stock_category
      t.string :stock_class
      t.string :group
      t.string :weight
      t.string :extra1
      t.string :extra2
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end
  end
end
