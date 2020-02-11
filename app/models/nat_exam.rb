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

  # def self.scores_for(student_id:, academic_year_id:)
  #   DiknasConvertedItem.student_scores(student_id: student_id, academic_year_id: academic_year_id)
  # end
  
  def self.students(academic_year:)
    Student.where(id: NatExam.for_academic_year(academic_year).pluck(:student_id))
    .order(:name)
  end

  def self.mock_data
    DiknasConvertedItem.school_scores(academic_year_id:19).each {|dci| 
      NatExam.create student_id:dci.student_id, 
        academic_year_id:19, grade_level_id:dci.grade_level_id, diknas_course_id:dci.course_id, 
        nilai_sekolah:dci.p_score, try_out_2:rand(dci.p_score-8..dci.p_score+5).round(0)
    }
  end

  def self.import_to_ii_scores(xlsx_file:, sheet:, academic_year_id:)
    xl = Roo::Spreadsheet.open(xlsx_file)
    sheet = xl.sheet(sheet)

    header = {"ID" => 'id', "NAME" => 'student'}
    header.merge! DiknasCourse::TRYOUTCOURSES.reduce(Hash.new) {|acc,c| acc.merge( c => DiknasCourse.find_by_name(c).id)}
    
    sheet.each_with_index(header) do |row, i| 
      next if i < 1 
      DiknasCourse::TRYOUTCOURSES.each do |diknas_course_name|
        nilai_sekolah = DiknasConvertedItem.student_score_for_diknas_course(student_id:row["ID"], academic_year_id: academic_year_id, diknas_course_id: header[diknas_course_name]).take
        if nilai_sekolah.present? || row[diknas_course_name].present?
          record = NatExam.find_or_create_by student_id: row["ID"], 
            academic_year_id: academic_year_id, 
            diknas_course_id: header[diknas_course_name],
            grade_level_id: 12
          record.update try_out_2: row[diknas_course_name], nilai_sekolah: nilai_sekolah.avg_score
        end
      end
    end
  end

end
