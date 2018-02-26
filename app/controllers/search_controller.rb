class SearchController < ApplicationController
  def index
    if params[:search_term]
      params[:search_term].split(" ").each do |each_term|
        term = each_term.downcase
        @books = @books ? 
          @books.where('LOWER(title) ~* ? or LOWER(description) ~* ? or isbn13 = ? or isbn10 = ? or authors ~* ?', term, term, term, term, term) :
          BookEdition.where('LOWER(title) ~* ? or LOWER(description) ~* ? or isbn13 = ? or isbn10 = ? or authors ~* ?', term, term, term, term, term)
        
        @tags = @tags ?
          @tags.where('tags ~* ?', term) : BookTitle.where('tags ~* ?', term)
        
        @book_copies = @book_copies ?
          @book_copies.where('LOWER(barcode) ~* ?', term) :
          BookCopy.where('LOWER(barcode) ~* ?', term).includes([:book_edition])

        @students = @students ? 
          @students.where('name ~* ?', term) : Student.where('name ~* ?', term)

        @employees = @employees ?
          @employees.where('name ~* ?', term) : Employee.where('name ~* ?', term)
      end
    end
  end 
end
