class AddColumnsToCourseText < ActiveRecord::Migration
  def change
    add_reference :course_texts, :book_category, index: true, foreign_key: true
    add_reference :course_texts, :book_edition, index: true, foreign_key: true
    add_column :course_texts, :notes, :string
  end
end
