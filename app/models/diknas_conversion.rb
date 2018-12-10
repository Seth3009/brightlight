class DiknasConversion < ActiveRecord::Base
  belongs_to :diknas_course
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level

  has_many :diknas_conversion_items, dependent: :destroy
  accepts_nested_attributes_for :diknas_conversion_items, reject_if: :all_blank, allow_destroy: true
  
  def self.value_for(student_id, diknas_course_id, academic_year_id, academic_term_id)
    find_by(diknas_course_id: diknas_course_id, academic_year_id: academic_year_id, academic_term_id: academic_term_id)
    .value_for student_id
  end

  def value_for(student_id) 
    avgs = course_averages(student_id) 
    avgs
    .reject { |x| x.nil? }
    .reduce(0.0) { |sum,x| sum+x } / avgs.count { |x| !x.nil? }
    .ceil # always round up
  end

  def course_averages(student_id) 
    diknas_conversion_items.map {|ci| 
      DiknasReportCard.value_for student_id: student_id, academic_year_id: ci.academic_year_id, academic_term_id: ci.academic_term_id, course_id: ci.course_id
    }
  end

  private
    def has_at_least_one_diknas_conversion_item     
      errors.add :diknas_conversion, 'must have at least one item' if diknas_conversion_items.empty?
    end
end
