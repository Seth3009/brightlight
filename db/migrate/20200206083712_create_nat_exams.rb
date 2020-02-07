class CreateNatExams < ActiveRecord::Migration
  def change
    create_table :nat_exams do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :grade_level, index: true, foreign_key: true
      t.belongs_to :academic_year, index: true, foreign_key: true
      t.belongs_to :diknas_course, index: true, foreign_key: true
      t.float :try_out_1
      t.float :try_out_2
      t.float :try_out_3
      t.float :ujian_sekolah
      t.float :nilai_sekolah
      t.float :ujian_nasional

      t.timestamps null: false
    end
  end
end
