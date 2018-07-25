namespace :data do
	desc "Import students and guardians"
	task import_students_and_guardians: :environment do

    # create_families

    xl = Roo::Spreadsheet.open('StudentDataExport.xlsx')
    sheet = xl.sheet('COMBINED')
    puts sheet.row(1)

    header = {no:"No", family_no:"Family No",student_no:"Student No", grade:"Grade", section: "Class", name: "Name",
              gender: "Gender", address_line_1: "Street", city: "City", country: "Country",
              place_of_birth: "Birth City", dob: "Birth Date", denomination: "Denomination", 
              fathers_name: "Father's Name", fathers_cell: "Father's WA CONTACT", fathers_cell_2: "Father's Cell Phone 1", 
              fathers_email: "Father's Email", fathers_email_2:  "Father's Email 2",
              mothers_name: "Mother's Name", mothers_cell: "Mother's WA CONTACT",
              mothers_cell_2:  "Mother's Cell Phone 1", mothers_email: "Mother's Email", mothers_email_2: "Mother's Email 2" }
    puts header

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      family = Family.find_by_family_no("%05d" % row[:family_no])
      student = Student.find_by_student_no row[:student_no]
      if student.blank?
        puts "#{row[:no]} - Student Number not found"
        #student = Student.where('name LIKE ?', "%#{row[:name]}%").take
      end   
      if student.present?
        # if row[:email].present?
        #   student.email = row[:email]
        # end
        student.admission_no = row[:student_no]
        student.family_id = family.id
        student.gender = row[:gender].first
        student.save
        add_to_grade_section student, row
        create_guardians family, student, row
        puts "#{i}. #{student.name}: existing #{student.admission_no}"        
      else 
        student = Student.new(
                    student_no: row[:student_no],
                    family_no:  row[:family_no],
                    family_id:  family.id,
                    name:       row[:name],
                    religion:   row[:denomination],
                    gender:     row[:gender].first,
                    # email:      row[:email],
                    date_of_birth:  row[:dob]
                  )
        student.save
        add_to_grade_section student, row
        create_guardians family, student, row
        puts "#{i}. #{student.name} (#{student.gender}) (No:#{student.student_no}/Fam:#{student.family_no})"      
      end
    end
  end
end

def create_families
  (1..5000).each { |n| Family.create family_number:n, family_no:"%05d" % n }
end

def create_guardians(family, student, data)
  ft_params = { 
      name:         data[:fathers_name],
      # home_phone:   data[:ft_contact],
      mobile_phone: data[:fathers_cell],
      other_phone:  data[:fathers_cell_2],
      email:        data[:fathers_email],
      email2:       data[:fathers_email_2],
      family_id:    family.id
  }
  father = Guardian.where(name: ft_params[:name], family_id: ft_params[:family_id]).first_or_create(ft_params)

  mt_params = {
      name:         data[:mothers_name],
      # home_phone:   data[:mt_contact],
      mobile_phone: data[:mothers_cell],
      other_phone:  data[:mothers_cell_2],
      email:        data[:mothers_email],
      email2:       data[:mothers_email_2],
      family_id:    family.id
  }
  mother = Guardian.where(name: mt_params[:name], family_id: mt_params[:family_id]).first_or_create(mt_params)
  family.family_members << FamilyMember.new(guardian: mother, relation: 'mother')
  family.family_members << FamilyMember.new(guardian: father, relation: 'father')
  family.family_members << FamilyMember.new(student: student, relation: 'child')
end

def add_to_grade_section(student, data)
  grade_level = GradeLevel.find data[:section][0..1].to_i
  grade_section = grade_level.grade_sections.where('name LIKE ?', "%#{data[:section].last}" ).take
  grade_section.grade_sections_students.create student: student, academic_year:AcademicYear.current, notes: data[:student_no]
end