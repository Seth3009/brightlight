class NatExam < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :academic_year
  belongs_to :diknas_course

  scope :for_academic_year, lambda { | year | where(academic_year_id: year) }
  scope :scores_for, lambda { |student_id: student_id, academic_year_id: AcademicYear.current_id|
    for_academic_year(academic_year_id)
    .where(student_id: student_id)
  }
  
  def self.students(academic_year:)
    Student.where id: NatExam.for_academic_year(academic_year).pluck(:student_id)
  end

  def self.mock_data
    DiknasConvertedItem.school_scores(academic_year_id:19).each {|dci| 
      NatExam.create student_id:dci.student_id, 
        academic_year_id:19, grade_level_id:dci.grade_level_id, diknas_course_id:dci.course_id, 
        nilai_sekolah:dci.p_score, try_out_2:rand(dci.p_score-8..dci.p_score+5).round(0)
    }
  end
end
