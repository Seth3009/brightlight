namespace :data do
	desc "Books to be disposed"
	task books_to_be_disposed: :environment do

    # Read Book title from Employee_Master
    xl = Roo::Spreadsheet.open('tmp/book-inventory.xlsx')
    sheet = xl.sheet('Inventory')

    header = {no: "NO",	title: "BOOK TITLE", barcode:	"NO BARCODE"}
    books = []
		sheet.each_with_index(header) do |row,i|
      next if i < 1
      books << row[:barcode].upcase.strip if row[:barcode].present?
    end
    open('tmp/books-disposed.csv', 'w') { |f|
      BookCopy.where('book_copies.barcode not in (?)', books)
        .joins(:book_edition)
        .joins('left join book_loans bl on bl.book_copy_id = book_copies.id and bl.academic_year_id >= 17')
        .where('bl.id is null')
        .select('book_editions.isbn10 as i10, book_editions.isbn13 as i13, book_copies.barcode as barcode, book_editions.title as title')
        .each {|x| f.puts "#{x.barcode}\t#{x.title}\t#{x.i13}\t#{x.i10}"}
    }
  end
end