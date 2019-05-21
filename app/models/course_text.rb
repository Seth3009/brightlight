class CourseText < ActiveRecord::Base
  belongs_to :course
  belongs_to :book_title
  belongs_to :book_category
  
  validates :course, presence: true
  validates :book_title, presence: true, uniqueness: {scope: [:course_id]}
  
  accepts_nested_attributes_for :book_title, reject_if: :all_blank

  def self.create_from_book_loans(employee:, academic_year:, category:, course:)
    loans = employee.book_loans.where(academic_year: academic_year)
              .group(:book_title_id,:book_category_id, :book_edition_id)
              .select(:book_title_id,:book_category_id, :book_edition_id)
    loans = loans.where(book_category_id: category) if category.present? && category != 'all'
    loans = loans.where(book_category_id: nil) if category == nil
    course.course_texts.create(
      loans.map do |book_loan|
        {book_title_id: book_loan.book_title_id,
        book_edition_id: book_loan.book_edition_id,
        book_category_id: book_loan.book_category_id}
      end
    )
  end
end
