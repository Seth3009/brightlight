class Invoice < ActiveRecord::Base
  belongs_to :student
  belongs_to :user
  belongs_to :academic_year
  
  has_many   :line_items, dependent: :destroy

  validates :total_amount, presence: true
  validates :bill_to, presence: true
  validates :student_id, presence: true
  validates :tag, uniqueness: true

  after_save :syncronize_paid_flag

  private

    def syncronize_paid_flag
      line_items.each do |line|
        line.book_fine.update_columns paid: paid
      end
    end

end
