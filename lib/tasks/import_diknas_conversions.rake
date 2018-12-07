namespace :data do
	desc "Import diknas conversions"
	task import_diknas_conversions: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConversions.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {course: 'course', year: 'year', term: 'term', pelajaran:'pelajaran', tahun:'tahun', semester:'semester', grade:'grade'}
 
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1
      
      diknas_course = DiknasCourse.find_by_name row[:pelajaran]
      tahun = AcademicYear.find_by_name row[:tahun]
      semesters = tahun.academic_terms.order(:id).map &:id

      course = Course.find_by_name row[:course]
      year = AcademicYear.find_by_name row[:year]
      terms = year.academic_terms.order(:id).map &:id

      dc = DiknasConversion.find_or_create_by(
        diknas_course_id: diknas_course.id,
        academic_year_id: tahun.id,
        academic_term_id: semesters[row[:semester]-1],                  
        grade_level_id: row[:grade] 
      )

      dc.diknas_conversion_items << DiknasConversionItem.new(
        course_id: course.id,
        academic_year_id: year.id,
        academic_term_id: terms[row[:term]-1]
      )
    end
  end
end
