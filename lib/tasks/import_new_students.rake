namespace :data do
	desc "Import new students"
	task import_new_students: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/new students 2017-2018.xlsx')
    sheet = xl.sheet('new20172018')

    header = {name:'Name',student_no:'School UD ID', family_no:'Family UD ID', gender:'Gender'}

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      student = Student.new(
                  student_no: row[:student_no],
                  family_no:  row[:family_no],
                  name:       row[:name],
                  gender:     row[:gender].try(:downcase)
                )
      student.save
      puts "#{i}. #{student.name} (#{student.gender}) (No:#{student.student_no}/Fam:#{student.family_no})"
    end
  end
end
