namespace :data do
  desc "Import student's dapodik data"
	task import_dapodik_data: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/student_dapodik.xlsx')
    sheet = xl.sheet('Sheet1')
    
    header = {
              student_no: "School UD ID",
              nisn: "NISN",
              nis: "Nomor Induk Siswa SMA",              
              nama: "Name",
              place_of_birth: "place_of_birth",
              dob: "DOB",
              religion: "Agama",
              gender: "Gender",
              child_order: "child_order",
              school_from: "School_From",
              accepted_grade: "accepted_grade",
              accepted_date: "accepted_date",
              address_line1: "alamat",
              dad: "dad",
              dad_occupations: "dad_occupations",
              mom: "mom",
              mom_occupations: "mom_occupations",
              guardian: "guardian",
              guardian_occupations: "guardian_occupations"
            }

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      # print "#{i}. #{row[:student_no]} #{row[:nisn]} : "
      student = Student.find_by student_no: row[:student_no]
      if student 
        student.update(
                      nisn: row[:nisn], 
                      nis: row[:nis],                       
                      name: row[:nama],
                      place_of_birth: row[:place_of_birth],
                      date_of_birth: row[:dob],
                      religion: row[:religion],
                      gender: row[:gender],
                      child_order: row[:child_order],
                      school_from: row[:school_from],
                      accepted_grade: row[:accepted_grade],
                      accepted_date: row[:accepted_date],
                      address_line1: row[:address_line1]
                      )
        guardians = Guardian.where(family_id: student.family_id)
        if guardians
          guardians.each do |guardian|            
              fm = FamilyMember.find_by(guardian_id: guardian.id)
              if fm.relation == 'father'
                guardian.update name: row[:dad], occupations:row[:dad_occupations]                
              elsif fm.relation == 'mother'
                guardian.update name: row[:mom], occupations:row[:mom_occupations]
              elsif fm.relation == 'guardian'
                guardian.update name: row[:guardian], occupations:row[:guardian_occupations]
              end
              puts "#{guardian.name} #{guardian.occupations}"            
          end
        end        
        puts "#{student.name} (No:#{student.student_no}/NISN:#{student.nisn})"
      else
        puts "Student not found"
      end
    end
  end
end
