namespace :data do
  desc "update_return_status"
  task update_return_status: :environment do
    bookloans = BookLoan.where(academic_year: 1..17, return_status: nil).all
    bookloans.each_with_index do |bookloan, index|
      bookloan.update(return_status:'R')
      puts index.to_s + ". " + bookloan.try(:book_edition).try(:title)
    end
  end
end
