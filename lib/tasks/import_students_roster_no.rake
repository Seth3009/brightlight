namespace :data do
	desc "Import students' roster numbers"
	task import_students_roster_no: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/rev3 STUDENT_DATABASE20182019.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {student_no:"STUDENTID(TEXT)", roster_no:"Roster No"}
    year_id = AcademicYear.current.id 

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      student = Student.find_by_student_no row[:student_no]
      if student.blank?
        puts "#{row[:no]} - Student Number not found"
      end   
      if student.present?
        gss = add_roster_no_to_grade_section(student, row[:roster_no], year_id)
        puts "#{i}. #{student.name} (#{gss.grade_section.name}) (No:#{row[:roster_no]})"      
      end
    end
  end
end

def add_roster_no_to_grade_section(student, roster_no, year_id)
  gss = GradeSectionsStudent.where(student: student, academic_year_id: year_id).take
  gss.order_no = roster_no.to_i 
  gss.save
  gss
end