class CreateDiknasReportConvertedItems < ActiveRecord::Migration
  def change
    create_table :diknas_report_converted_items do |t|
      t.belongs_to :diknas_report_converted, index: true, foreign_key: true
      t.belongs_to :diknas_conversion, index: true, foreign_key: true
      t.float :P_score
      t.float :T_score
      t.text :comment

      t.timestamps null: false
    end
  end
end
