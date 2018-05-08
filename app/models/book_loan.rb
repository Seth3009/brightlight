class BookLoan < ActiveRecord::Base

  validates :book_copy, presence: true
  validates :academic_year, presence: true
  validates :book_copy_id, uniqueness: {scope: [:academic_year_id, :return_status]},
              if: Proc.new { |record| !record.return_status },
              on: :create
  # validates :book_copy_id, uniqueness: {scope: [:academic_year_id]},
  #             if: Proc.new { |record| record.return_status },
  #             on: :update

  belongs_to :book_copy
  belongs_to :book_edition
  belongs_to :book_title
  belongs_to :student
  belongs_to :employee
  belongs_to :book_category
  belongs_to :loan_type
  belongs_to :academic_year
  belongs_to :prev_academic_year, class_name: "AcademicYear"
  belongs_to :user

  has_many :loan_checks, dependent: :destroy
  has_one  :student_book

  around_destroy :make_book_status_available
  before_save :sync_status_available, if: :return_status_changed? 
  before_save :sync_status_onloan,    if: :loan_status_changed?
  before_create :sync_status_onloan

  scope :current, lambda { where(academic_year: AcademicYear.current) }
  scope :returned, lambda { where(return_status:'R') }
  scope :not_returned, lambda { where(return_status: nil) }
  scope :with_title_and_subject, lambda { joins('LEFT JOIN book_titles ON book_titles.id = book_loans.book_title_id')  
            .joins('LEFT JOIN book_editions ON book_editions.id = book_loans.book_edition_id')   
            .joins('LEFT JOIN subjects ON book_titles.subject_id = subjects.id')                       
            .select('book_loans.*, book_editions.title as title, subjects.name as subject') }

  
  scope :not_disposed, lambda { 
    where('book_loans.book_copy_id NOT IN (
        select id from book_copies where disposed = true
      )')
  }

  def self.list_for_teacher(teacher_id, year)
    loans = BookLoan.includes([:employee,:book_copy,:book_edition,:academic_year])
                .joins('LEFT JOIN book_titles ON book_titles.id = book_loans.book_title_id')
                .joins("LEFT JOIN subjects ON subjects.id = book_titles.subject_id")
                .not_disposed
                .select('book_loans.*, subjects.name as subject, book_titles.title as title')
    if year.present? && year.downcase != 'all' 
      loans = loans.where(academic_year_id:year)
    elsif year.blank?
      loans =  loans.current
    end
    loans = loans.where(employee_id:teacher_id) if teacher_id.present?
  end

  def self.list_for_teachers_receipt(year_id, teacher_id)
    BookLoan.select(['COUNT (book_loans.id) AS loan_qty',
        "COUNT (case when book_loans.return_status = 'R' then 1 else null end) AS return_qty",
        'subjects.name','book_editions.title','book_editions.authors','book_editions.publisher', 
        'book_editions.isbn13', 'book_editions.isbn10', 'book_editions.refno', 'book_loans.notes'])
      .where('book_loans.academic_year_id = ? AND book_loans.employee_id = ?', year_id, teacher_id)      
      .not_disposed
      .joins("LEFT JOIN book_editions ON book_editions.id = book_loans.book_edition_id")
      .joins("LEFT JOIN book_titles ON book_titles.id = book_loans.book_title_id")
      .joins("LEFT JOIN subjects ON subjects.id = book_titles.subject_id")
      .group('subjects.name','book_editions.title', 'book_editions.authors','book_editions.publisher', 'book_editions.isbn13', 'book_editions.isbn10', 'book_editions.refno', 'book_loans.notes')
      .order('name','title')
  end

  def self.initialize_teacher_loans_from_previous_year(previous_year_id, new_year_id, user_id)
    columns = [:book_copy_id, :book_edition_id, :book_title_id, :person_id, :book_category_id, :loan_type_id,
                :out_date, :due_date, :academic_year_id, :user_id, :barcode, :refno,
                :prev_academic_year_id, :loan_status, :bkudid, :employee_id, :deleted_flag]
    values = []
    BookLoan.not_disposed.where(academic_year_id: previous_year_id).where.not(employee_id: nil).each do |bl|
      data = [bl.book_copy_id, bl.book_edition_id, bl.book_title_id, bl.person_id, bl.book_category_id, bl.loan_type_id,
                Date.today, Date.today+360, new_year_id, user_id, bl.barcode, bl.refno,
                previous_year_id, 'B', bl.bkudid, bl.employee_id, false]
      values << data
    end
    BookLoan.import columns, values
  end

  # BookLoan.move_all_books(from:Employee.find(3),to:Employee.find(4),from_year:AcademicYear.current_id-1,to_year:AcademicYear.current, current_user)
  def self.move_all_books(from:, to:, from_year:, to_year:, exclude_unreturned_books: true, user_id:)
    source = Employee.find(from.id)
    destination = Employee.find(to.id)

    # This would be efficient, but it doesn't update the updated_at field
    # BookLoan.where(employee:source,academic_year:from_year).update_all(employee_id:to.id, academic_year_id:to_year.id)

    tmp = source.book_loans.not_disposed.where(academic_year:from_year).map { |x|
            x.attributes.except('created_at', 'updated_at', 'id', 'loan_status', 'return_status', 'return_date', 'out_date', 'due_date', 'user_id')
            .merge('academic_year_id'=>to_year, 'loan_status'=>'B', 'out_date'=>Date.today, 'due_date'=>Date.today+360, 'user_id'=>user_id)
          } 
    source.book_loans.not_disposed.where(academic_year:from_year).delete_all if from_year == to_year
    destination.book_loans.create(tmp)
  end

  def move_book(to:, to_year:nil)
    if to_year == nil or academic_year_id == to_year.id
      r = update_attribute :employee, to
      return !!r
    else
      r = BookLoan.create attributes
            .except('created_at', 'updated_at', 'id', 'return_status', 'return_date', 'out_date', 'due_date', 'employee_id', 'user_id')
            .merge('employee_id'=>to.id, 'academic_year_id'=>to_year.id, 'loan_status'=>'B', 'out_date'=>Date.today, 'due_date'=>Date.today+360, 'user_id'=>user_id)
      return r.valid?
    end
  end
  
  def grade_section_name
    student.grade_section_with_academic_year_id(self.academic_year_id).try(:name) if student.present?
  end

  private

  # Whenever return status is changed, also change book_copy status
  # TODO: loan status and return status should be combined into 1 field
  def sync_status_available
    if self.return_status == 'R' or self.return_status == 'RI'
      self.loan_status = nil
      self.book_copy.update_column :status_id, 1   # Status: available
    end
  end 

  def sync_status_onloan
    if self.loan_status == 'B'
      self.book_copy.update_column :status_id, 2   # Status: on loan
    end
  end

  def make_book_status_available
    book_copy = self.book_copy
    yield
    book_copy.update_column :status_id, 1   # Status: available
  end
end
