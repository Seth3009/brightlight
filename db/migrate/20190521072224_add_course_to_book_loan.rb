class AddCourseToBookLoan < ActiveRecord::Migration
  def change
    add_reference :book_loans, :course, index: true, foreign_key: true
    add_reference :book_loans, :course_section, index: true, foreign_key: true
  end
end
