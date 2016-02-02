class GradeSection < ActiveRecord::Base
  validates :name, presence: true
  validates :academic_year, presence: true

  belongs_to :grade_level
  belongs_to :homeroom, class_name: "Employee"
  belongs_to :academic_year

  has_many :course_sections
  has_many :grade_sections_students, dependent: :destroy
  has_many :students, through: :grade_sections_students
  has_many :book_labels
  has_many :student_books

  scope :with_academic_year_id, lambda {|id| where(academic_year_id: id)}

  accepts_nested_attributes_for :students
  accepts_nested_attributes_for :grade_sections_students, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :book_labels, allow_destroy: true, reject_if: :all_blank

  def textbooks
    course_sections.map { |cs| cs.textbooks } unless course_sections.blank?
  end

  def self.default_scope
    where(academic_year_id: AcademicYear.current_id)
  end

end
