class CourseText < ActiveRecord::Base
  belongs_to :course
  belongs_to :book_title
  belongs_to :book_category
  
  validates :course, presence: true
  validates :book_title, presence: true, uniqueness: {scope: [:course_id]}
  
  accepts_nested_attributes_for :book_title, reject_if: :all_blank

  def self.create_from_book_loans(employee:, academic_year:, course:)
    course.course_texts.create(
      employee.book_loans.where(academic_year: academic_year)
        .group(:book_title_id,:book_category_id, :book_edition_id)
        .select(:book_title_id,:book_category_id, :book_edition_id)
        .map do |book_loan|
          {book_title_id: book_loan.book_title_id,
          book_edition_id: book_loan.book_edition_id,
          book_category_id: book_loan.book_category_id}
        end
    )
  end
end
