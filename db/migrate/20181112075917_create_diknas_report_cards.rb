class CreateDiknasReportCards < ActiveRecord::Migration
  def change
    create_table :diknas_report_cards do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :grade_level, index: true, foreign_key: true
      t.belongs_to :grade_section, index: true, foreign_key: true
      t.belongs_to :academic_year, index: true, foreign_key: true
      t.belongs_to :academic_term, index: true, foreign_key: true
      t.string :course_belongs_to
      t.float :average
      t.text :notes

      t.timestamps null: false
    end
  end
end
