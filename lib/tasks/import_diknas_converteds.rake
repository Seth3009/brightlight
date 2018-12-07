namespace :data do
	desc "Import diknas converteds"
	task import_diknas_converteds: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConvertedItems.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {conversion_id: 'conversion id', np: 'np', nt: 'nt', student:'student',
        year:'year', term:'term', grade_level:'grade_level'}
 
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1

      student = Student.find_by_student_no row[:student]
      year = AcademicYear.find_by_name row[:year]
      terms = year.academic_terms.order(:id).map &:id

    
      dc = DiknasConverted.find_or_create_by(
        student_id: student.id,
        academic_year_id: year.id,
        academic_term_id: terms[row[:term]-1],                  
        grade_level_id: row[:grade_level] 
      )

      dc.diknas_converted_items << DiknasConvertedItem.new(
        diknas_conversion_id: row[:conversion_id],
        P_score: row[:np],
        T_score: row[:nt]
      )
    end
  end
end
