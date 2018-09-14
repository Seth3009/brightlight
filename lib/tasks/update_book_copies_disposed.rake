namespace :data do
	desc "update book copies disposed"
	task update_book_copies_disposed: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/disposed_book.xlsx')
    sheet = xl.sheet('disposed')

    header = {id:'id',barcode:'barcode'}

    sheet.each_with_index(header) do |row,i|
      next if i < 1
      if row[:id].present?
        book = BookCopy.where(id:row[:id].to_i).first
        if book.present?
          book.update(disposed:true)
          puts "#{i}. #{book.id} #{book.barcode}"        
        end      
      end
    end    
  end
end
