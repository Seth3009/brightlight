class StudentBook < ActiveRecord::Base
  belongs_to :student
  belongs_to :book_copy
  belongs_to :book_edition
  belongs_to :academic_year
  belongs_to :prev_academic_year, class_name: "AcademicYear"
  belongs_to :course_text
  belongs_to :grade_section
  belongs_to :grade_level
  belongs_to :course
  belongs_to :initial_copy_condition, class_name: "BookCondition"
  belongs_to :end_copy_condition, class_name: "BookCondition"
  belongs_to :book_loan

  has_many :book_fines
  
  validates :student, presence: true
  validates :book_copy, presence: true
  validates :academic_year, presence: true
  # validates :course, presence: true
  # validates :course_text, presence: true
  validates :grade_level, presence: true
  validates :grade_section, presence: true
  validates :book_copy, uniqueness: { scope: [:academic_year_id],
    message: "cannot add same book in the same academic year" }

  after_save :update_book_copy_condition
  after_update :sync_book_loan
  after_validation :create_associated_book_loan, on: [:create]
  around_destroy :destroy_associated_book_loan

  accepts_nested_attributes_for :book_loan

  scope :current_year, lambda { where(academic_year:AcademicYear.current) }
  scope :not_disposed, lambda { 
    where('student_books.book_copy_id NOT IN (
        select id from book_copies where disposed = true
      )')
  }

  # SQL version:
  # SELECT * FROM student_books
  # LEFT JOIN grade_sections_students gss on gss.student_id = student_books.student_id
  # JOIN grade_sections gs ON gs.id = student_books.grade_section_id
  # JOIN standard_books ON student_books.book_edition_id = standard_books.book_edition_id
  #             AND standard_books.grade_level_id = gs.grade_level_id
  #             AND standard_books.book_category_id = 1
  #             AND standard_books.academic_year_id = 16
  #             AND (standard_books.track = gss.track OR standard_books.track is null)
  # LEFT JOIN book_editions ON student_books.book_edition_id = book_editions.id
  # WHERE student_books.academic_year_id = 16
  # 	AND gs.grade_level_id = 11
  scope :standard_books, lambda { |grade_level_id, grade_section_id, year_id, category_id|
    joins("LEFT JOIN grade_sections_students gss on gss.student_id = student_books.student_id 
            AND gss.academic_year_id = student_books.academic_year_id")
    .joins("LEFT JOIN standard_books ON student_books.book_edition_id = standard_books.book_edition_id
            AND standard_books.grade_level_id = student_books.grade_level_id
            AND standard_books.book_category_id = #{category_id}
            AND standard_books.academic_year_id = student_books.academic_year_id
            AND (standard_books.track = gss.track OR standard_books.track is null)")
    .joins('LEFT JOIN book_editions ON student_books.book_edition_id = book_editions.id')
    .where(academic_year_id: year_id)
    .where(grade_level_id: grade_level_id)
    .select('student_books.*, book_editions.title as title, student_books.grade_section_id as book_no')
  }

  scope :pnnrb_columns, lambda { joins('LEFT JOIN book_editions ON student_books.book_edition_id = book_editions.id')
                        .joins('LEFT JOIN book_labels ON book_labels.student_id = student_books.student_id')
                        .select('student_books.*, book_editions.title as title, student_books.grade_section_id as book_no')}

  scope :only_standard_books, lambda { |grade_level_id, grade_section_id, year_id, category_id|
    joins("LEFT JOIN grade_sections_students gss on gss.student_id = student_books.student_id 
            AND gss.academic_year_id = student_books.academic_year_id")
    .joins("JOIN standard_books ON student_books.book_edition_id = standard_books.book_edition_id
            AND standard_books.grade_level_id = student_books.grade_level_id
            AND standard_books.book_category_id = #{category_id}
            AND standard_books.academic_year_id = student_books.academic_year_id
            AND (standard_books.track = gss.track OR standard_books.track is null)")
    .joins('LEFT JOIN book_editions ON student_books.book_edition_id = book_editions.id')
    .where(academic_year_id: year_id)
    .where(grade_level_id: grade_level_id)
    .select('student_books.*, book_editions.title as title')
  }

  scope :fine_applies, lambda {
    joins('join fine_scales fs on student_books.initial_copy_condition_id=fs.old_condition_id and student_books.end_copy_condition_id=fs.new_condition_id')
    .select('student_books.*, fs.percentage as fine_pct')
  }

  scope :for_grade, lambda { |academic_year_id:, grade_section_id:|
    where(academic_year_id:academic_year_id, grade_section_id: grade_section_id)
  }

  scope :unique_book_editions, lambda {
    joins(:book_edition)
    .group('book_edition_id, book_editions.title')
    .select('book_edition_id as id, book_editions.title as title')
    .order('book_editions.title')
  }

  scope :unique_book_titles, lambda { 
    joins(:book_edition)
    .joins('join book_titles on book_titles.id = book_editions.book_title_id')
    .group('book_titles.id, book_titles.title')
    .select('book_titles.id as id, book_titles.title as title')
    .order('book_titles.title')
  }

  scope :including_conditions, lambda {
    includes({book_copy: :book_label}, :initial_copy_condition, :end_copy_condition)
  }

  scope :by_editions, lambda {
    joins(:book_edition)
    .order('book_editions.title, CAST(roster_no as INT)')
  }

  scope :by_titles, lambda {
    joins(:book_edition)
    .joins('join book_titles on book_titles.id = book_editions.book_title_id')
    .order('book_titles.title, CAST(roster_no as INT)')
  }

  scope :for_edition, lambda { |book_edition_id|
    where(book_edition_id: book_edition_id)
  }

  scope :for_title, lambda { |book_title_id|
    where(book_titles: {id: book_title_id} )
  }


  # def fine_applies
  #   initial_copy_condition_id.present? && end_copy_condition_id.present?
  #   && (end_copy_condition_id - initial_copy_condition_id > 2 || end_copy_condition_id == 5)
  # end

  def initial_condition
    initial_copy_condition #|| book_copy.current_start_condition
  end

  def end_condition
    end_copy_condition
  end

  # Create student book records for a specific student and year, from Book Receipt
  def self.initialize_from_book_receipts(gss:, year:)
    student = gss.student
    if student.present?
      grade_section = student.grade_section_with_academic_year_id(year.id)
      roster_no = student.roster_no_with_academic_year_id(year.id)
      if BookReceipt.where(grade_section:grade_section, roster_no:roster_no, academic_year:year).count > 0
        # Create StudentBook record
        StudentBook.create(
          BookReceipt.where(grade_section:grade_section, roster_no:roster_no, academic_year:year).map { |receipt|
            receipt.attributes
            .except('id', 'created_at', 'updated_at', 'notes', 'roster_no', 'active', 'initial_condition_id', 'return_condition_id')
            .merge('roster_no' => receipt.roster_no.to_s, 'student_id' => student.id, 'issue_date' => receipt.created_at,
                    'deleted_flag' => false, 'student_no' => student.student_no,
                    'initial_copy_condition_id' => receipt.initial_condition_id)
          } 
        )  
      end
    else
      logger.error "Preparing StudentBook. Student not found for #{gss.grade_section.name} no. #{gss.order_no} #{gss.student_id}"
    end
  end

  def self.create_book_loan(sb)
    book_title_id = sb.book_edition.try(:book_title_id)
    book_title = BookTitle.where(id: book_title_id).take
    standard_book = StandardBook.where(book_title_id: book_title_id, academic_year_id:sb.academic_year_id).take
    book_category = standard_book.try(:book_category_id)

    # Create BookLoan record
    book_loan = BookLoan.create({
      academic_year_id: sb.academic_year_id,
      barcode:          sb.barcode,
      book_edition_id:  sb.book_edition_id,
      book_title_id:    book_title_id,
      book_category_id: book_category,
      bkudid:           book_title.try(:bkudid),
      book_copy_id:     sb.book_copy_id,
      out_date:         sb.issue_date,
      loan_status:      'B',
      refno:            sb.book_edition.try(:refno),
      roster_no:        sb.roster_no,
      student_id:       sb.student_id,
      student_no:       sb.student_no,
      deleted_flag:     false
    })
    sb.update_column :book_loan_id, book_loan.id
    sb.book_copy.update_column :status_id, 2    # (Status on loan)
  end

  private
    def create_associated_book_loan
      book_title_id = self.book_edition.try(:book_title_id)
      book_title = BookTitle.where(id: book_title_id).take
      standard_book = StandardBook.where(book_title_id: book_title_id, academic_year_id:self.academic_year_id).take
      book_category = standard_book.try(:book_category_id)

      # Create BookLoan record
      book_loan = BookLoan.create({
        academic_year_id: self.academic_year_id,
        barcode:          self.barcode,
        book_edition_id:  self.book_edition_id,
        book_title_id:    book_title_id,
        book_category_id: book_category,
        bkudid:           book_title.try(:bkudid),
        book_copy_id:     self.book_copy_id,
        out_date:         self.issue_date,
        loan_status:      'B',
        refno:            self.book_edition.try(:refno),
        roster_no:        self.roster_no,
        student_id:       self.student_id,
        student_no:       self.student_no,
        deleted_flag:     false
      })
      self.book_loan_id = book_loan.id 
      if self.book_copy.present?  
        self.book_copy.update_column(:status_id, 2)     # (Status on loan)
      else
        logger.error "ERROR: Book Copy not found: ID##{self.book_copy_id}"
      end
    end

    def sync_book_loan
      if book_loan = self.book_loan
        book_loan.academic_year_id = self.academic_year_id
        book_loan.barcode = self.barcode
        book_loan.book_edition_id = self.book_edition_id
        book_loan.book_title_id = self.book_edition.try(:book_title_id)
        book_loan.book_copy_id = self.book_copy_id
        book_loan.out_date = self.issue_date
        book_loan.roster_no = self.roster_no
        book_loan.student_id = self.student_id
        book_loan.student_no = self.student_no
        book_loan.save
      else
        logger.error "Student Book #{self.id}: associated book_loan record not found"
      end
    end  

    # This method is called by around_save
    def update_book_copy_condition
      unless book_copy.book_condition_id == end_copy_condition_id
        book_copy.update(book_condition_id: end_copy_condition_id)
      end
    end

    def destroy_associated_book_loan
      book_loan = self.book_loan
      yield
      book_loan.destroy if book_loan
    end
end
