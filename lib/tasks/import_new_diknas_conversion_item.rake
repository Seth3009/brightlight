namespace :data do
	desc "Import new diknas conversion item"
	task import_new_diknas_conversion_item: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConversionItem.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {diknas: 'diknas', course:'course',year:'year',semester:'sem'}
    # course = Course.find_by_name '2017-2018'

    sheet.each_with_index(header) do |row,i|
        puts "#{i}, #{row}"
		next if i < 1
            course = Course.find_by_name row[:course]
            academicyear = AcademicYear.find_by_name row[:year]

    #   grade_section = GradeSection.find_by_name row[:section_name]

            if row[:semester] == 1
                academicterm = AcademicTerm.where(academic_year_id: academicyear.id).first
            else
                academicterm = AcademicTerm.where(academic_year_id: academicyear.id).last
            end

      dc = DiknasConversionItem.new(
                  diknas_conversion_id: row[:diknas],
                  course_id: course.id,
                  academic_year_id: academicyear.id,
                  academic_term_id: academicterm.id
                )
      dc.save
    #   puts "#{i}. #{student.name} (No:#{student.student_no}/Fam:#{student.family_no})"
    end
  end
end
