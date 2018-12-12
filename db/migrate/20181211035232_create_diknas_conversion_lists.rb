class CreateDiknasConversionLists < ActiveRecord::Migration
  def change
    create_table :diknas_conversion_lists do |t|
      t.belongs_to :diknas_conversion, index: true, foreign_key: true
      t.integer :conversion_id
      t.float :weight
      t.string :notes

      t.timestamps null: false
    end
  end
end
