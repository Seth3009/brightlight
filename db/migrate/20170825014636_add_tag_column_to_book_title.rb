class AddTagColumnToBookTitle < ActiveRecord::Migration
  def change
    add_reference :book_titles, :grade_level, index: true, foreign_key: true
    add_column :book_titles, :track, :string
    add_column :book_titles, :tags, :string
  end
end
