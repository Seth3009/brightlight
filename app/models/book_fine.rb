class BookFine < ActiveRecord::Base
  belongs_to :book_copy
  belongs_to :academic_year
  belongs_to :student
  belongs_to :old_condition, class_name: 'BookCondition'
  belongs_to :new_condition, class_name: 'BookCondition'
  belongs_to :student_book
  belongs_to :grade_section
  belongs_to :grade_level
  has_many :line_items, dependent: :destroy

  validates :book_copy_id, presence: true, uniqueness: {scope: [:student_id, :academic_year_id]}
  validates :student_id, presence: true
  validates :academic_year_id, presence: true
  validates :fine, presence: true
  
  scope :not_disposed, lambda { 
    where('book_fines.book_copy_id NOT IN (
        select id from book_copies where disposed = true
      )')
  }

  scope :for_grade_section_year, lambda { |grade_section_id, academic_year_id|
    where("student_id in
      (SELECT students.id FROM students INNER JOIN grade_sections_students
      ON grade_sections_students.student_id = students.id
      WHERE grade_sections_students.grade_section_id = ?
      AND grade_sections_students.academic_year_id = ?)", grade_section_id, academic_year_id)
  }

  # collect_current will read student_books table and look for book that are applicable for book fine
  # for the current academic year and then save them in book_fines table
  def self.collect_fines(year)
    BookFine.create(StudentBook.not_disposed.where(academic_year:year).fine_applies.map do |b|
      pct = FineScale.fine_percentage_for_condition_change(b.initial_copy_condition_id,b.end_copy_condition_id)
      price = b.book_copy.book_edition.price.to_f rescue 0.0
      {
        book_copy_id:     b.book_copy_id,
        old_condition_id: b.initial_copy_condition_id,
        new_condition_id: b.end_copy_condition_id,
        academic_year_id: b.academic_year_id,
        student_id:       b.student_id,
        percentage:       pct,
        fine:             pct * price,
        currency:         b.book_copy.try(:book_edition).try(:currency)
      }
    end)
  end

  def self.collect_fines_for_grade_level grade_level, year: year
    puts "Deleting unpaid Fines for grade #{grade_level}"
    BookFine.where(academic_year_id: year, grade_level: grade_level).where('paid is not true').destroy_all
    StudentBook.where(academic_year: year).where(grade_level: grade_level).fine_applies.each do |b|
      pct = FineScale.fine_percentage_for_condition_change(b.initial_copy_condition_id,b.end_copy_condition_id)
      price = b.book_copy.book_edition.price.to_f rescue 0.0
      book_copy = b.book_copy
      if book_copy
        puts "Updating unpaid Fines for loan #{b.student.name} #{b.book_copy.barcode}"
        book_fine = BookFine.find_or_create_by(academic_year_id: year, book_copy_id: book_copy.id)
        book_fine.update_attributes(
          book_copy_id:     b.book_copy_id,
          old_condition_id: b.initial_copy_condition_id,
          new_condition_id: b.end_copy_condition_id,
          academic_year_id: b.academic_year_id,
          student_id:       b.student_id,
          grade_level_id:   b.grade_level_id,
          grade_section_id: b.grade_section_id,
          student_book_id:  b.id,
          percentage:       pct,
          fine:             pct * price,
          currency:         b.book_copy.try(:book_edition).try(:currency)
        ) unless book_fine.paid
      end
    end
  end

  def self.create_invoice_for(student:, total_amount:, academic_year:, exchange_rate:1, foreign_currency:'USD', invoice_currency:'Rp', round_to_hundreds:true, current_user: )
    book_fines = self.where(academic_year:academic_year).where(student:student)

    # The tag is to identify the invoice with the book fines
    tag = Digest::MD5.hexdigest "#{academic_year.id}-#{student.id}-#{total_amount}"
    invoice = Invoice.find_by_tag tag
    unless invoice.present?
      invoice = Invoice.create(
          student: student,
          bill_to: student.name,
          grade_section: student.current_grade_section.name,
          roster_no: student.current_roster_no,
          total_amount: round_to_hundreds ? total_amount.to_f.round(-2) : total_amount,
          currency: invoice_currency,
          academic_year_id: academic_year.id,
          statuses: 'Created',
          paid: false,
          tag: tag,
          user: current_user
      )
      if invoice.valid?
        invoice.line_items.create(
          book_fines.map do |book_fine|
            idr_amount = book_fine.currency==foreign_currency ? book_fine.fine * exchange_rate : book_fine.fine rescue 0.0
            {
              description: book_fine.book_copy.try(:book_edition).try(:title),
              price: idr_amount,
              ext1: book_fine.old_condition.code,
              ext2: book_fine.new_condition.code,
              ext3: "#{book_fine.percentage * 100}%",
              book_fine_id: book_fine.id
            }
          end
        )
      end
    end
    return invoice
  end

end
