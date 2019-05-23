SELECT book_loans.*, courses.number as course_number, courses.name as course_name, subjects.name as subject, book_titles.subject_id, book_titles.tags as tags, 
		book_titles.id as title_id, e.id as edition_id, e.title as title, e.authors, e.isbn10, e.isbn13, e.publisher, e.small_thumbnail, 
		c.code as catg_code, c.name as catg_name,     l.id as check_id, l.user_id as checked_by, l.loaned_to, l.scanned_for, l.emp_flag, 
		l.matched, l.notes as check_notes,
		employees.id as emp_id, employees.name as emp_name
FROM book_loans
INNER JOIN book_copies ON book_copies.id = book_loans.book_copy_id AND (book_copies.disposed = false OR book_copies.disposed is null)
LEFT JOIN courses ON book_loans.course_id = courses.id
LEFT JOIN book_titles ON book_titles.id = book_loans.book_title_id
LEFT JOIN book_editions e ON e.id = book_loans.book_edition_id
LEFT JOIN book_categories c ON c.id = book_loans.book_category_id
LEFT JOIN subjects ON subjects.id = book_titles.subject_id
LEFT JOIN employees ON employees.id = book_loans.employee_id
LEFT JOIN ( select book_loan_id, academic_year_id, max(created_at) max_date 
		from loan_checks 
		where matched = true
		group by matched, book_loan_id, academic_year_id ) max_dates 
	ON max_dates.book_loan_id = book_loans.id AND max_dates.academic_year_id = book_loans.academic_year_id
LEFT JOIN loan_checks l ON l.book_loan_id = book_loans.id
	and l.academic_year_id = book_loans.academic_year_id
	and l.loaned_to = book_loans.employee_id
	and l.matched = true 
	and max_dates.book_loan_id = l.book_loan_id 
	and max_dates.max_date = l.created_at
