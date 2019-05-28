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
  scope :current, lambda { where(academic_year_id: AcademicYear.current_id) }
  
  def has_course_texts?
    course_texts.present?
  end

  def number_and_name
    "#{number} - #{name}"
  end

  def self.initialize_from_previous_year (prev_academic_year_id, new_academic_year_id, grade_levels)
    Course.where(academic_year_id: prev_academic_year_id, grade_level_id: grade_levels).each do |c|
      nc = Course.create name: c.name, number: c.number, description: c.description, grade_level_id: c.grade_level_id, 
            academic_year_id:new_academic_year_id, employee_id: c.employee_id, slug: c.slug, subject_id: c.subject_id, 
            course_department_id: c.course_department_id, level: c.level
      
      c.course_sections.each do |cs|
        CourseSection.create name: cs.name, course_id: nc.id, grade_section_id: cs.grade_section_id, 
          instructor_id: cs.instructor_id, slug: cs.slug, instructor2_id: cs.instructor2_id, 
          aide_id: cs.aide_id, sem1: cs.sem1, sem2: cs.sem2, location_id: cs.location_id
      end

      c.course_texts.each do |ct|
        CourseText.create course_id: nc.id, book_title_id: ct.book_title_id, order_no: ct.order_no, 
          book_category_id: ct.book_category_id, book_edition_id: ct.book_edition_id, notes: ct.notes
      end
    end

  end

end
