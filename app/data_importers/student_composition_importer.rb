class StudentCompositionImporter
  attr_reader :academic_year, :sheet, :logs, :header

  HEADER = {
    no:'Count', name:'Name', student_no:'School UD ID', family_no:'Family UD ID', roster_no:'NO STD',
    birth_date:'Birth Date', birth_place:'Birth City', denomination: 'Denomination',
    gender:'Gender', grade_name:'Grade', class_code:'Class',
    address:'Street', city:'City', country:'Country',
    ft_name:'Ft. First Name', ft_mobile:'Ft. Cell Phone', 
    ft_occupation:'Ft. Occupation', ft_email_1:'Ft. Email', ft_email_2:'Ft. Email2',
    mt_name:'Mt. First Name', mt_mobile:'Ft. Cell Phone', 
    mt_occupation:'Mt. Occupation', mt_email_1:'Mt. Email', mt_email_2:'Mt. Email2',
  }

  def initialize(academic_year_id, xlsx_file, sheet_name)
    @academic_year = AcademicYear.find academic_year_id
    @sheet = Roo::Spreadsheet.open(xlsx_file).sheet(sheet_name)
    @logs = []
    @header = get_header(@sheet.row(1))
  end

  def import
    sheet.each_with_index(header) do |row,i|
      next if i < 1  # skip the header row
      student_no = row[:student_no].to_i.to_s
      student = Student.find_or_initialize_by student_no: student_no
      student.attributes = student_attributes(row)
      log(student, {i: i, info: row[:class_code]})
      puts logs[i]
      student.save
      update_grade_sections student, row, academic_year.id
      update_family_members student, row
    end
    save_logs
  end


  def log(student, opts)
    log = "#{opts[:i]}. #{student.name} #{opts[:info]} (No:#{student.student_no}/Fam:#{student.family_no})"
    log = "#{log} [New student]" unless student.persisted? 
    logs << log
  end

  def update_grade_sections(student, data, academic_year_id)
    grade_level, grade_section = get_grade_level_and_section data[:class_code]
    grade_section.grade_sections_students << GradeSectionsStudent.new(
                student_id: student.id,
                academic_year_id: academic_year_id,
                order_no: data[:roster_no].to_i,
                notes: student.student_no
              )
  end

  def update_family_members(student, data)
    family = student.family
    if data[:ft_name].present?
      family.update_guardian :father, father_attributes(data)
    end
    if data[:mt_name].present?
      family.update_guardian :mother, mother_attributes(data)
    end
    family.update_child student
  end

  def get_grade_level_and_section(class_code)
    code = class_code.to_s.strip
    level = GradeLevel.find code[0..1].to_i
    section = level.grade_sections.where('name like ?',"%#{code[-1]}").take
    [level, section]
  end

  # Adjust the header to account for invisible spaces in the header string
  def get_header(header_row)
    HEADER.each do |k,v| 
      HEADER[k] = header_row[header_row.index{|s| s.include? v}] 
    end
  end

  def save_logs
    File.write('tmp/import_logs.txt', logs.join("\n"), mode: "a")
  end

  def student_attributes(data)
    {
      student_no:     data[:student_no].to_i.to_s,
      family_no:      fam_no = "%05d" % data[:family_no],
      name:           data[:name].strip,
      gender:         data[:gender].try(:first).try(:downcase),
      date_of_birth:  data[:birth_date],
      place_of_birth: data[:birth_place],
      religion:       data[:denomination],
      is_active:      true,
      address_line1:  data[:address],
      city:           data[:city],
      country:        data[:country],
      family_id:      Family.find_by(family_no: fam_no).id
    }
  end

  def father_attributes(data)
    fam_no = "%05d" % data[:family_no]
    phone1, phone2 = data[:ft_mobile].split(',').map(&:strip) unless data[:ft_mobile].blank?
    {
      name:           data[:ft_name],
      mobile_phone:   phone1,
      other_phone:    phone2,
      address_line1:  data[:address],
      city:           data[:city],
      country:        data[:country],
      email:          data[:ft_email_1],
      email2:         data[:ft_email_2],
      occupations:    data[:ft_occupation],
      family_id:      Family.find_by(family_no: fam_no).id
    }
  end

  def mother_attributes(data)
    fam_no = "%05d" % data[:family_no]
    phone1, phone2 = data[:mt_mobile].split(',').map(&:strip) unless data[:mt_mobile].blank?
    {
      name:           data[:mt_name],
      mobile_phone:   phone1,
      other_phone:    phone2,
      address_line1:  data[:address],
      city:           data[:city],
      country:        data[:country],
      email:          data[:mt_email_1],
      email2:         data[:mt_email_2],
      occupations:    data[:mt_occupation],
      family_id:      Family.find_by(family_no: fam_no).id
    }
  end

end
