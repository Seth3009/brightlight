class CopyCondition < ActiveRecord::Base
  belongs_to :book_copy
  belongs_to :book_condition
  belongs_to :academic_year
  belongs_to :user   # user that did the checking

  validates :academic_year, :start_date, :book_copy_id, :book_condition, :barcode, presence: true

  scope :current_year, lambda { where(academic_year:AcademicYear.current) }
  scope :active, lambda { where('deleted_flag = false OR deleted_flag is NULL').where.not(academic_year_id:nil) }

  scope :for_label, lambda { |label|
    joins(:book_copy).where(book_copies: {book_label_id: label})
  }

  # Callbacks to ensure BookCopy.book_condition_id is the same as the one we're updating
  # NOTE: This assumes that we are NOT going to update old records, and we are NOT going 
  #       to create back date condition. Otherwise, the book_conditoin_id in BookCopy
  #       will be wrong 
  around_save :update_book_copy_condition
  after_create :synchronize_book_copy_condition
  after_destroy :revert_book_copy_condition

  def update_book_copy_condition
    old_condition_id = book_condition_id
    old_copy_condition = book_copy.latest_copy_condition

    yield

    old_copy_condition.update_column(:end_date, Date.today) if old_copy_condition.present?
    if old_condition_id != book_condition_id
      synchronize_book_copy_condition
    end
  end

  def synchronize_book_copy_condition
    book_copy.update_column :book_condition_id, book_condition_id
  end

  def revert_book_copy_condition
    book_copy.update_column :book_condition_id, book_copy.copy_conditions.order(:updated_at).take.try(:book_condition_id)
  end

end
