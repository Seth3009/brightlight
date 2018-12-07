class CreateDiknasConvertedItems < ActiveRecord::Migration
  def change
    create_table :diknas_converted_items do |t|
      t.belongs_to :diknas_converted, index: true, foreign_key: true
      t.belongs_to :diknas_conversion, index: true, foreign_key: true
      t.float :p_score
      t.float :t_score
      t.text :comment

      t.timestamps null: false
    end
  end
end
