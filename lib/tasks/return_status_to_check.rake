namespace :data do
	desc "Return status to check"
  task :return_status_to_check, [:employee_id, :academic_year_id] => :environment do |task, args|
    empl = args[:employee_id]
    year = args[:academic_year_id]
    
    puts "Changing return status for #{Employee.find(empl).name}" 
    BookLoan.where(academic_year_id: year, employee_id: empl, return_status: 'R').each do |bl|
      bl.loan_checks << LoanCheck.new(
        academic_year_id: year,
        loaned_to: empl,
        scanned_for: empl,
        book_copy_id: bl.book_copy_id, 
        emp_flag: true, 
        matched: true,
        user_id: bl.user_id
      )
      bl.return_status = nil
      bl.return_date = nil
      bl.save
      puts bl.barcode
    end
  end
end

  