class CreateDiknasConversionItems < ActiveRecord::Migration
  def change
    create_table :diknas_conversion_items do |t|
      t.references :diknas_conversion, index: true, foreign_key: true
      t.belongs_to :course, index: true, foreign_key: true
      t.belongs_to :academic_year, index: true, foreign_key: true
      t.belongs_to :academic_term, index: true, foreign_key: true
      t.float :weight
      t.text :notes

      t.timestamps null: false
    end
  end
end
