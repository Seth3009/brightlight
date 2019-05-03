class CourseSection < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :course
  belongs_to :grade_section
  belongs_to :instructor, class_name: "Employee"
  belongs_to :instructor2, class_name: "Employee"
  belongs_to :aide, class_name: "Employee"
  belongs_to :location

  has_many :rosters, dependent: :destroy
  has_many :students, through: :rosters

  scope :with_grade_level, lambda {|grade_level| joins(:grade_section).where(grade_sections: {grade_level_id: grade_level})}
  scope :with_course, lambda {|course| where(course: course)}

  def textbooks
    if course.has_course_texts?
      course.book_titles
    end unless course.blank?
  end

end
