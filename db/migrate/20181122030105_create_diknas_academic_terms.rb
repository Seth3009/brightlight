class CreateDiknasAcademicTerms < ActiveRecord::Migration
  def change
    create_table :diknas_academic_terms do |t|
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
