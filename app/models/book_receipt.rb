class BookReceipt < ActiveRecord::Base
  belongs_to :book_copy
  belongs_to :academic_year
  belongs_to :student
  belongs_to :book_edition
  belongs_to :grade_section
  belongs_to :grade_level
  belongs_to :initial_condition, class_name: "BookCondition"
  belongs_to :return_condition, class_name: "BookCondition"
  belongs_to :course
  belongs_to :course_text

  #validates :book_copy, presence:true
  validates :academic_year, presence:true
  validates :grade_section, presence:true
  validates :grade_level, presence:true
  validates :roster_no, presence:true
  # validates :book_copy, uniqueness: {scope: [:academic_year_id]}
  # validates :initial_condition, presence:true

  # after_save :update_book_copy_condition

  scope :not_disposed, lambda { 
    where('book_receipts.book_copy_id NOT IN (
        select id from book_copies where disposed = true
      )')
  }

  def self.initialize_book_receipts(previous_year_id, new_year_id, grade_levels)
    initialize_with_standard_books(previous_year_id, new_year_id, grade_levels)
  end

  def self.initialize_with_standard_books(previous_year_id, new_year_id, grade_levels)
    textbook_category = BookCategory.find_by_code 'TB'
    GradeLevel.where(id: grade_levels).each do |grade_level|
      StandardBook.where(academic_year_id: new_year_id, book_category: textbook_category, grade_level: grade_level).each do |std_book|
        grade_level.grade_sections.each do |grade_section|
          if grade_section.capacity
            (1..grade_section.capacity).each do |num|
              create_from_student_book(previous_year_id, new_year_id, grade_section, std_book, num)
            end
          end
        end
      end
    end
  end

  POOR = BookCondition.find_by_slug('poor').id
  MISSING = BookCondition.find_by_slug('missing').id

  def self.create_from_student_book(previous_year_id, new_year_id, grade_section, std_book, roster_no)
    book_receipt = BookReceipt.new academic_year_id: new_year_id,
      grade_section_id: grade_section.id,
      grade_level_id: grade_section.grade_level_id,
      roster_no: roster_no,
      book_edition_id: std_book.book_edition_id

    all_editions = std_book.book_title.book_editions.map(&:id)
    student_book = StudentBook.find_by(
        academic_year_id: previous_year_id, 
        grade_section_id: grade_section.id,
        book_edition_id: all_editions,
        roster_no: roster_no)
    
    if student_book.present?
      book_condition_id = student_book.book_copy.try(:latest_condition).try(:id)

      unless book_condition_id == POOR || book_condition_id == MISSING 
        book_receipt.book_copy_id = student_book.book_copy_id
        book_receipt.barcode      = student_book.barcode
        book_receipt.copy_no      = student_book.copy_no
        book_receipt.book_edition_id = student_book.book_edition_id
        book_receipt.initial_condition_id = book_condition_id
      end
    else
      puts "#{roster_no} Student book not found #{std_book.book_title.title}"
    end

    book_receipt.save
  end

  def self.initialize_with_student_books_for_grade(previous_year_id, new_year_id, grade_section_id)
    columns = [:book_copy_id, :barcode, :book_edition_id, :academic_year_id, :initial_condition_id,
               :grade_section_id, :grade_level_id, :roster_no, :course_id]
    textbook_category = BookCategory.find_by_code 'TB'
    values = []
    grade_section = GradeSection.find grade_section_id
    # grade_level_id = grade_section.grade_level_id
    # Books with 'Poor / Missing' condition will not be included
    poor = BookCondition.find_by_slug 'poor'
    missing = BookCondition.find_by_slug 'missing'
    student_books = StudentBook.where(grade_section:grade_section,academic_year_id:previous_year_id)
                      .only_standard_books(grade_section.grade_level.id, grade_section.id, new_year_id, textbook_category.id)
                      .joins(:book_copy)
                      .where('book_copies.book_condition_id != ?', poor.id)
                      .where('book_copies.book_condition_id != ?', missing.id)

    student_books.each_with_index do |sb,i|
      data = [sb.book_copy_id, sb.barcode, sb.book_edition_id, new_year_id, sb.book_copy.book_condition_id,
              sb.grade_section_id, sb.grade_level_id, sb.roster_no.to_i, sb.course_id]
      values << data
      if i % 120 == 0
        BookReceipt.import columns, values
        values = []
      end
    end

    unless values.empty?
      BookReceipt.import columns, values
    end
  end

  def self.initialize_with_student_books(grade_section:, previous_year:, new_year:)
    textbook_category = BookCategory.find_by_code 'TB'

    # Books with 'Poor / Missing' condition will not be included
    poor = BookCondition.find_by_slug 'poor'
    missing = BookCondition.find_by_slug 'missing'
    student_books = StudentBook.where(grade_section: grade_section, academic_year_id: previous_year)
                      .joins(:book_copy)
                      .where('book_copies.book_condition_id != ?', poor.id)
                      .where('book_copies.book_condition_id != ?', missing.id)
    BookReceipt.create(student_books.map { |sb|
      { book_copy_id: sb.book_copy_id, barcode: sb.barcode, book_edition_id: sb.book_edition_id,
        academic_year_id: new_year, initial_condition_id: sb.book_copy.book_condition_id,
        grade_section_id: sb.grade_section_id, grade_level_id: sb.grade_level_id, roster_no: sb.roster_no.to_i, course_id: sb.course_id
      }
    })
    student_books.count
  end

  # Create book_copy's condition based on the condition in book_receipt
  def self.finalize_receipts_conditions(year_id, current_user_id, grade_levels)
    receipts = BookReceipt.joins(:book_copy,:academic_year)
                .where(academic_year_id:year_id)
                .where("grade_level_id in (?)", grade_levels)
                .select('book_receipts.*, academic_years.start_date as start_date')
    receipts.each do |receipt|
      latest_condition = CopyCondition.where(book_copy_id: receipt.book_copy_id, academic_year_id: year_id, post: 0)
                          .order('created_at desc').take
      condition_id = receipt.initial_condition_id
      if latest_condition.blank? || latest_condition.try(:book_condition_id) != condition_id
        CopyCondition.create({
          book_copy_id: receipt.book_copy_id,
          book_condition_id: condition_id,
          academic_year_id: year_id,
          start_date: receipt.issue_date || receipt.start_date,
          barcode: receipt.barcode || receipt.book_copy.barcode,
          notes: 'Initial condition from Book Receipt',
          user_id: current_user_id,
          post: 0,                  # (inital condition)
          deleted_flag: false
        })
      end
    end
  end 
  
  def finalize_receipts_conditions(year_id, current_user_id)
    latest_condition = CopyCondition.where(book_copy_id: book_copy_id, academic_year_id: year_id, post: 0)
                        .order('created_at desc').take
    condition_id = initial_condition_id
    if latest_condition.blank? || latest_condition.try(:book_condition_id) != condition_id
      CopyCondition.create({
        book_copy_id: book_copy_id,
        book_condition_id: condition_id,
        academic_year_id: year_id,
        start_date: issue_date || academic_year.start_date,
        barcode: barcode || book_copy.try(:barcode),
        notes: 'Initial condition from Book Receipt',
        user_id: current_user_id,
        post: 0,                  # (inital condition)
        deleted_flag: false
      })
    end
  end

  def student
    GradeSectionsStudent.where(academic_year: academic_year, order_no: roster_no.to_s, grade_section: grade_section).take.student
  end 
  
  private

    def update_book_copy_condition
      if initial_condition_id != book_copy.book_condition_id
        book_copy.copy_conditions.create([
                academic_year_id: academic_year_id,
                book_condition_id: initial_condition_id,
                barcode: barcode,
                notes: 'Updated through Receipt Form',
                start_date: Date.today,
                deleted_flag: false,
                post: 0
            ])
      end
    end

end
