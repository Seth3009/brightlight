class AddSubjectColumnToStandardBook < ActiveRecord::Migration
  def change
    add_reference :standard_books, :subject, index: true, foreign_key: true
  end
end
