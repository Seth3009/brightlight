namespace :data do
	desc "Import new course"
	task import_new_course: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/coursesG12-2019.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {no:'no',name:'name',number:'number', description:'description', grade_level_id:'grade_level_id',
              academic_year_id:'academic_year_id', academic_term_id:'academic_term_id', employee_id:'employee_id'}

    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
			next if i < 1

      puts "Importing row #{i}. #{row[:number]}"
      course = Course.find_or_create_by(number: row[:number], academic_year_id:nil)
      course.update(
        name: row[:name],
        number: row[:number],
        description: row[:description],
        grade_level_id: row[:grade_level_id],
        academic_year_id: row[:academic_year_id],
        academic_term_id: row[:academic_term_id],
        employee_id: row[:employee_id]
      )
    end
  end
end
