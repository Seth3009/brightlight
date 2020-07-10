class DiknasReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :course

  validates_presence_of :student_id, :grade_level_id, :academic_year_id, :academic_term_id, :course_id

  def self.value_for(student_id: student_id, academic_term_id: academic_term_id, course_id: course_id) 
    record = DiknasReportCard.find_by student_id: student_id, academic_term_id: academic_term_id, course_id: course_id
    record.try(:average)
  end
  
  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('Sheet1')

    header = {student_id: "School UD ID", grade: "Grade Level", course: "Course ID",
      average: "Avg", year: "Year", academic_term: "Semester"}
    
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1
      
      student = Student.find_by_student_no(row[:student_id])
      year = row[:year].slice(0..8)
      academic_year = AcademicYear.find_by_name(year)
      terms = academic_year.academic_terms.order(:start_date).map &:id
      course = Course.where(id: row[:course]).take

      diknas_report_card = DiknasReportCard.find_by(student_id: student.id,
        grade_level_id:   row[:grade],
        course_id:        course.id,
        academic_term_id: terms[row[:academic_term]-1]
      )
      if diknas_report_card.present?
        diknas_report_card.update average: row[:average]
      else
        diknas_report_card = DiknasReportCard.new(
          student_id:       student.id,
          grade_level_id:   row[:grade],
          course_id:        course.id,
          average:          row[:average],
          academic_year_id: academic_year.id,
          academic_term_id: terms[row[:academic_term]-1]
        )
        diknas_report_card.save
      end
    end 
  end

  def self.records_for(student_id: student_id, academic_year_id: academic_year_id)
    DiknasReportCard.where(student_id: student_id, academic_year_id: academic_year_id)
      .order(:course_id, :academic_term_id)
      .group_by(&:course_id)
      .map do |course_id, recs|
        record = Hash.new
        record[:course_id] = course_id
        recs.each do |rec|
          record[rec.academic_term_id] = rec.average
        end  
        record
      end  
  end

  def self.convert(academic_term_id: academic_term_id, grade_level_id: grade_level_id)
    academic_year_id = AcademicTerm.find(academic_term_id).academic_year_id
    Student.joins(:grade_sections_students)
      .joins('join grade_sections on grade_sections.id = grade_sections_students.grade_section_id')
      .joins("join grade_levels on grade_levels.id = grade_sections.grade_level_id AND grade_levels.id=#{grade_level_id}")
      .where(grade_sections_students: {academic_year_id: academic_year_id})
      .each do |student|
        dc = DiknasConverted.find_or_create_by(student_id: student.id, academic_year_id: academic_year_id, academic_term_id: academic_term_id, grade_level_id: grade_level_id)
        DiknasConversion.where(academic_term_id: academic_term_id, grade_level_id: grade_level_id)
          .each do |diknas_conversion|
            score = diknas_conversion.value_for(student.id)
            score = score.nan? || score == Float::INFINITY ? nil : score
            converted_item = dc.diknas_converted_items.find_by(diknas_conversion_id: diknas_conversion.id)
            if converted_item.present?
              converted_item.update(
                p_score: score,
                t_score: score
              ) 
            else
              converted_item = DiknasConvertedItem.new(
                diknas_conversion_id: diknas_conversion.id,
                p_score: score,
                t_score: score
              )
              dc.diknas_converted_items << converted_item
            end
          end
      end
  end 

end
