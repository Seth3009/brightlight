class BookCopy < ActiveRecord::Base
  belongs_to :book_edition
  belongs_to :book_condition
  belongs_to :status
  belongs_to :book_label
  validates :book_edition, presence: true
  validates :barcode, presence: true, uniqueness: true, format: { with: /\A[A-Z0-9-]+\Z/,
    message: "Invalid barcode format: only capital letters, numbers & '-' character, no spaces allowed" }
  has_many :copy_conditions, dependent: :destroy
  has_many :book_fines, dependent: :restrict_with_error
  has_many :book_loans, dependent: :restrict_with_error
  has_many :book_loan_histories
  has_many :book_receipts, dependent: :restrict_with_error
  has_many :student_books, dependent: :restrict_with_error
  has_many :loan_checks, dependent: :restrict_with_error
  has_one  :book_title, through: :book_edition

  after_create :create_initial_condition
  before_save :upcase_and_trim_barcode
  before_save :sync_book_label, if: :book_label_id_changed?
  before_save :sync_book_edition, if: :book_edition_id_changed?

  def self.default_scope
    where('disposed = false OR disposed is null')
  end

  scope :not_disposed, lambda { where.not(disposed: true) }

  scope :standard_books, lambda { |grade_level_id, grade_section_id, year_id|
    if grade_level_id <= 10
      joins("JOIN standard_books ON book_copies.book_edition_id = standard_books.book_edition_id
              AND #{grade_level_id} = standard_books.grade_level_id
              AND standard_books.academic_year_id = #{year_id}")
    else
      joins("JOIN standard_books ON book_copies.book_edition_id = standard_books.book_edition_id
              AND #{grade_section_id} = standard_books.grade_section_id
              AND standard_books.academic_year_id = #{year_id}")
    end
  }

  
  scope :with_condition, lambda { |condition_id|
    query = self.joins('left join copy_conditions c on c.book_copy_id = book_copies.id and c.id = (select id from copy_conditions 
                    where book_copy_id = book_copies.id and (deleted_flag = false or deleted_flag is null) and academic_year_id is not null 
                    order by academic_year_id desc, created_at desc limit 1)')   
                .joins('left join book_labels on book_copies.book_label_id = book_labels.id')                                
                .joins('left join book_conditions bc on bc.id = c.book_condition_id')
                .select('book_copies.barcode, book_copies.id, book_copies.status_id, book_copies.notes, book_copies.book_label_id, book_copies.book_condition_id, book_labels.name as label, c.book_condition_id as condition_id, bc.code as cond_code, bc.color as cond_color')
    case condition_id 
    when 'na'
      query.where('c.id is null')
    when '1'..'5'
      query.where('c.book_condition_id = ?', condition_id)
    else
      query
    end
  }

  scope :with_status, lambda { |status_id|
    query = self.joins('left join statuses on statuses.id = book_copies.status_id').select('statuses.name as status_name')
    case status_id 
    when 'na'
      query.where('status_id is null')
    when 'all', nil
      query
    else
      query.where(status_id: status_id)
    end
  }

  scope :with_active_loans, lambda { |year|
    joins("left join book_loans l on l.book_copy_id = book_copies.id and l.return_status is null and l.academic_year_id = #{year}")
    .joins('left join employees e on e.id = l.employee_id')
    .joins('left join students s on s.id = l.student_id')
    .select('e.name as teacher_name, e.id as teacher_id, s.name as student_name, s.id as student_id')
  } 

  def cover_image
    book_edition.try(:small_thumbnail) || 'book-icon.png'
  end

  def create_condition(condition_id, year_id, user_id)
    self.copy_conditions << CopyCondition.new(
        book_condition_id: condition_id,
        academic_year_id: year_id,
        barcode: barcode,
        notes: 'Batch condition update',
        user_id: user_id,
        start_date: Date.today,
        post: 0
      )
    # Note: CopyCondition will synchronize the book_condition_id attribute after creating the new record
  end 

  def latest_copy_condition
    copy_conditions.active.order('academic_year_id DESC,created_at DESC').take
  end

  def latest_condition
    book_condition || 
    copy_conditions.active.order('copy_conditions.academic_year_id DESC,copy_conditions.created_at DESC')
      .take.try(:book_condition)
  end

  def current_start_condition
    copy_conditions.current_year.active.where(post:0).first.try(:book_condition)
  end

  def last_return_condition
    copy_conditions.where(post:1).order('academic_year_id DESC').first.try(:book_condition)
  end

  def start_condition_in_year(academic_year_id)
    copy_conditions.where(academic_year_id:academic_year_id).where(post:0).order(created_at: :desc)
      .first.try(:book_condition)
  end

  def return_condition_in_year(academic_year_id)
    copy_conditions.where(post:1).where(academic_year_id:academic_year_id).first.try(:book_condition)
  end

  def active_loan
    BookLoan.where(book_copy_id: self.id, return_status: nil)
      .order(academic_year_id: :desc, created_at: :desc)
      .includes([:employee, :student])
      .take
  end

  def borrowed_in_year(year_id)
    !!book_loans.where(academic_year_id: year_id, return_status: nil).present?
  end 

  # Create copy_conditions records based
  def self.update_conditions_from_student_books(academic_year_id, next_academic_year_id, grade_levels)
    category = BookCategory.find_by_code 'TB'
    columns = [:book_copy_id, :barcode, :book_condition_id, :start_date, :end_date, :academic_year_id, :notes, :post, :deleted_flag]

    GradeSection.where("grade_level_id in (?)", grade_levels).each do |grade_section|
      return_conditions = []
      starting_conditions = []
      puts "Updating conditions for section #{grade_section.name}"
      student_books = StudentBook.where(academic_year_id:academic_year_id)
                        .where(grade_section: grade_section)
                        .where.not(end_copy_condition_id:nil)
                        .where.not(book_copy_id:nil)
                        .includes([:book_copy])
      if student_books.present?
        student_books.each_with_index do |sb, i|
          return_condition = [sb.book_copy_id, sb.barcode, sb.end_copy_condition_id, sb.return_date || Date.today, sb.return_date, academic_year_id, 'Return condition', 1, false]
          return_conditions << return_condition
          # starting_condition = [sb.book_copy_id, sb.barcode, sb.end_copy_condition_id, sb.return_date || Date.today, nil, next_academic_year_id, 'Starting condition', 0, false]
          # starting_conditions << starting_condition
        end

        if return_conditions.count > 0
          CopyCondition.import columns, return_conditions, validates: false
          # CopyCondition.import columns, starting_conditions, validates: false
        end
      end
    end
  end

  def self.ucfst(sb, academic_year_id, next_academic_year_id)
    bc = sb.book_copy
    bc.copy_conditions << CopyCondition.new(
      book_condition_id: sb.end_copy_condition_id,
      academic_year_id: academic_year_id,
      barcode: sb.barcode,
      notes: 'Return condition',
      start_date: sb.return_date || Date.today,
      end_date: sb.return_date,
      post: 1
    )
    bc.copy_conditions << CopyCondition.new(
      book_condition_id: sb.end_copy_condition_id,
      academic_year_id: next_academic_year_id,
      barcode: sb.barcode,
      notes: 'Starting condition',
      start_date: sb.return_date || Date.today,
      post: 0
    )
  end

  def self.copy_with_barcode(barcode)
    BookCopy.where(barcode:barcode).first
  end

  def dispose
    self.disposed = true
    self.disposed_at = Time.zone.now
    self.save
  end 

  def undispose
    self.disposed = false
    self.disposed_at = nil
    self.save
  end 

  def destroy_and_leave_no_trace!
    self.copy_conditions.destroy_all     if self.copy_conditions
    self.book_fines.destroy_all          if self.book_fines
    self.loan_checks.destroy_all         if self.loan_checks
    self.book_loans.destroy_all          if self.book_loans
    self.book_loan_histories.destroy_all if self.book_loan_histories
    self.book_receipts.destroy_all       if self.book_receipts
    self.student_books.destroy_all       if self.student_books
    self.destroy
  end 

  protected
    def create_initial_condition
      self.copy_conditions << CopyCondition.new(
        book_condition_id: book_condition_id,
        academic_year:AcademicYear.current,
        barcode: barcode,
        notes: 'Initial condition',
        start_date: Date.today,
        post: 0
      )
    end

    def sync_book_label
      self.copy_no = book_label.try(:name)
    end

    def sync_book_edition
      book_loans.update_all book_edition_id: self.book_edition_id
      book_loan_histories.update_all book_edition_id: self.book_edition_id
      book_receipts.update_all book_edition_id: self.book_edition_id
      student_books.update_all book_edition_id: self.book_edition_id
    end

    def upcase_and_trim_barcode
      self.barcode = self.barcode.strip.upcase
    end
end
