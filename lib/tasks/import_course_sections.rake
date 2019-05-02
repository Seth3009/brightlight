namespace :data do
	desc "Import course sections"
	task import_course_sections: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/SOLSORCLassList2019.xlsx')
    sheet = xl.sheet('IMPORT')

    header = {department: 'Department', title: 'Title', name: 'Name', section: 'Section', room: 'Room', instructor_id:'ID'}

    academic_year_id = AcademicYear.current.id

    sheet.each_with_index(header) do |row,i|
			next if i < 1

      puts "Importing row #{i}. #{row[:title]} #{row[:section]}"
      
      department = CourseDepartment.find_or_create_by(name: row[:department])
      location = Location.find_or_create_by(name: row[:room])
      location.update(code: row[:room])

      course = Course.find_or_create_by(
        number: row[:name],
        academic_year_id: academic_year_id
      )
      grade_level_id = course.number.match /(\d{2})[A-Z].+/
      course.update(
        name: row[:title],
        grade_level_id: grade_level_id,
        course_department_id: department.id
      )
      course_section = CourseSection.find_or_create_by(
        name: row[:section],
        course_id: course.id
      )
      course_section.update(
        location_id: location.id,
        instructor_id: row[:instructor_id]
      )
    end
  end
end
