class DiknasConversion < ActiveRecord::Base
  belongs_to :diknas_course
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level
  belongs_to :diknas_conversion

  has_many :diknas_conversion_items, dependent: :destroy
  has_many :diknas_conversion_lists
  has_many :conversions, through: :diknas_conversion_lists, source: :conversion

  accepts_nested_attributes_for :diknas_conversion_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :diknas_conversion_lists, reject_if: :all_blank, allow_destroy: true

  def self.list_for_select
    DiknasConversion.joins([:diknas_course, :grade_level, :academic_term])
      .select(:id, "(diknas_courses.name || ' - ' || grade_levels.name || ' - ' || academic_terms.name) as name")
      .order([:academic_term_id, :grade_level_id, 'diknas_courses.name'])
  end

  def self.value_for(student_id, diknas_course_id, academic_year_id, academic_term_id)
    find_by(diknas_course_id: diknas_course_id, academic_year_id: academic_year_id, academic_term_id: academic_term_id)
    .value_for student_id
  end

  def value_for(student_id) 
    values = course_values(student_id).reject(&:nil?) 
    average = values.sum.to_f / values.count
    
    average.nan? || average == Float::INFINITY ? average : average.ceil.to_f # always round up
  end

  def course_values(student_id) 
    values = diknas_conversion_items.where(substitute: false).map {|ci| 
      DiknasReportCard.value_for student_id: student_id, academic_year_id: ci.academic_year_id, academic_term_id: ci.academic_term_id, course_id: ci.course_id
    }.reject &:nil?
    if values.blank?
      values = diknas_conversion_items.where(substitute: true).map {|ci| 
        DiknasReportCard.value_for student_id: student_id, academic_year_id: ci.academic_year_id, academic_term_id: ci.academic_term_id, course_id: ci.course_id
      }
    end
    values + diknas_conversion_lists.map {|item|
      item.conversion.value_for student_id
    }
  end

  private
    def has_at_least_one_diknas_conversion_item     
      errors.add :diknas_conversion, 'must have at least one item' if diknas_conversion_items.empty?
    end
end
