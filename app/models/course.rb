class Course < ActiveRecord::Base
  belongs_to :grade_level
  belongs_to :academic_year
  has_and_belongs_to_many :academic_terms
  belongs_to :employee
  belongs_to :subject
  belongs_to :course_department
  
  validates :number, presence: true, uniqueness: {scope: [:academic_year_id, :academic_term_id]}
  validates :academic_year, presence: true

  has_many :course_sections, dependent: :destroy
  accepts_nested_attributes_for :course_sections, allow_destroy: true, reject_if: :all_blank

  has_many :course_texts, dependent: :destroy
  has_many :book_titles, through: :course_texts
  accepts_nested_attributes_for :course_texts, allow_destroy: true, reject_if: :all_blank

  scope :with_grade_level, lambda {|grade_level| joins(:grade_level).where(grade_levels: {id: grade_level}) }

  def has_course_texts?
    course_texts.present?
  end

  def name_and_number
    "#{name} - #{number}"
  end

end
