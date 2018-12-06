class DiknasReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :course

  validates_presence_of :student_id, :grade_level_id, :academic_year_id, :academic_term_id, :course_id

  def self.value_for(student_id: student_id, academic_year_id: academic_year_id, academic_term_id: academic_term_id, course_id: course_id) 
    record = DiknasReportCard.find_by student_id: student_id, academic_year_id: academic_year_id, course_id: course_id
    record.try(:average)
  end
  
  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('Sheet1')

    header = {student_id: "School UD ID ", grade: "Grade Level ", course: "Base Course ",
      average: "Avg ", year: "Year ", academic_term: "Semester "}
    
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1
      
      student = Student.find_by_student_no(row[:student_id])
      year = row[:year].slice(0..8)
      academic_year = AcademicYear.find_by_name(year)
      terms = academic_year.academic_terms.order(:start_date).map &:id
      course = Course.find_by_name(row[:course])

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
