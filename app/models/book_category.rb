class BookCategory < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  has_many  :standard_books, dependent: :restrict_with_error
  has_many  :book_loans, dependent: :restrict_with_error
end
