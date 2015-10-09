class CreateBookGrades < ActiveRecord::Migration
  def change
    create_table :book_grades, id: false do |t|
      t.belongs_to :book_copy, index: true, foreign_key: true
      t.references :book_condition, index: true, foreign_key: true
      t.references :academic_year, index: true, foreign_key: true
      t.string :notes
      t.integer :graded_by
      t.string :notes
      t.date :checked_date
      
      t.timestamps null: false
    end
  end
end
