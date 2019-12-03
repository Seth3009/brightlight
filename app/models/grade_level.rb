class GradeLevel < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  has_many :grade_sections,  -> { order(:id) }, dependent: :restrict_with_error
  has_many :book_labels
  has_many :book_titles, dependent: :restrict_with_error
  has_many :grade_section_histories,  -> { order(:id) }
  has_many :standard_books
  belongs_to :school_level
  has_many :diknas_conversions

  accepts_nested_attributes_for :grade_sections, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :book_labels, allow_destroy: true, reject_if: :all_blank

  scope :option_list_diknas_conversion, lambda { includes('diknas_conversions').where.not(diknas_conversions: {grade_level_id:nil}).all} 
  def self.roman(id)
    arr = ["VII","VIII","IX","X","XI","XII"]
    roman = arr[self.find(id).id.to_i-7]
    return roman
  end

  def self.options_for_select
		order(:id).map {|grade| [grade.name, grade.id]}
	end
end
