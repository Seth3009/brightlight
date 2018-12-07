namespace :data do
	desc "Import new diknas conversion"
	task import_new_diknas_conversion: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConversion.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {id:'no', course:'pelajaran', year:'year',semester:'semester', grade_level_id:'grade'}
    # course = Course.find_by_name '2017-2018'

    sheet.each_with_index(header) do |row,i|
        puts "#{i}, #{row}"
		next if i < 1
            course = DiknasCourse.find_by_name row[:course]
            academicyear = AcademicYear.find_by_name row[:year]

    #   grade_section = GradeSection.find_by_name row[:section_name]

            if row[:semester] == 1
                academicterm = AcademicTerm.where(academic_year_id: academicyear.id).first
            else
                academicterm = AcademicTerm.where(academic_year_id: academicyear.id).last
            end

      dc = DiknasConversion.new(
                  id: row[:id],
                  diknas_course_id: course.id,
                  academic_year_id: academicyear.id,
                  academic_term_id: academicterm.id,                  
                  grade_level_id: row[:grade_level_id]
                  
                )
      dc.save
    #   puts "#{i}. #{student.name} (No:#{student.student_no}/Fam:#{student.family_no})"
    end
  end
end
