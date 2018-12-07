namespace :data do
	desc "Import student's NISN"
	task import_students_nisn: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/NIS.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {student_no: "School UD ID", nisn: "NISN", nis: "Nomor Induk Siswa SMA"}

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      print "#{i}. #{row[:student_no]} #{row[:nisn]} : "
      student = Student.find_by student_no: row[:student_no]
      if student
        student.update nisn: row[:nisn], nis: row[:nis]
        puts "#{student.name} (No:#{student.student_no}/NISN:#{student.nisn})"
      else
        puts "Student not found"
      end
    end
  end
end
