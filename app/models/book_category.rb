class BookCategory < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  has_many  :standard_books
  has_many  :book_loans
end
