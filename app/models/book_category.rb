class BookCategory < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  has_many  :book_titles
  has_many  :standard_books
end
