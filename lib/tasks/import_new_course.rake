namespace :data do
	desc "Import new course"
	task import_new_course: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/courses.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {name:'name',number:'number', description:'description', grade_level_id:'grade_level_id',
              academic_year_id:'academic_year_id', academic_term_id:'academic_term_id', employee_id:'employee_id'}
    # course = Course.find_by_name '2017-2018'

    sheet.each_with_index(header) do |row,i|
			next if i < 1
    #   course = Student.find_by_student_no row[:student_no]
    #   grade_section = GradeSection.find_by_name row[:section_name]
      puts "Importing row #{i}. #{row[:number]}"
      course = Course.new(
                  name: row[:number],
                  number: row[:number],
                  description: row[:description],
                  grade_level_id: row[:grade_level_id],
                  academic_year_id: row[:academic_year_id],
                  academic_term_id: row[:academic_term_id],
                  employee_id: row[:employee_id]
                )
      course.save
    #   puts "#{i}. #{student.name} (No:#{student.student_no}/Fam:#{student.family_no})"
    end
  end
end
