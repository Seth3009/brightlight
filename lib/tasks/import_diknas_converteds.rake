namespace :data do
	desc "Import diknas converteds"
	task import_diknas_converteds: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConvertedItems.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {np: 'np', nt: 'nt', student:'student',
        year:'year', term:'term', grade_level:'grade_level',
        pelajaran: 'pelajaran', tahun: 'tahun', semester: 'semester', grade: 'grade'
      }
 
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1

      student = Student.find_by_student_no row[:student]
      year = AcademicYear.find_by_name row[:year]
      terms = year.academic_terms.order(:id).map &:id
    
      dc = DiknasConverted.find_or_create_by(
        student_id: student.id,
        academic_year_id: year.id,
        academic_term_id: terms[row[:term]-1],                  
        grade_level_id: row[:grade_level] 
      )

      tahun = AcademicYear.find_by_name row[:tahun]
      semesters = tahun.academic_terms.order(:id).map &:id

      conversion = DiknasConversion.find_by(
        diknas_course_id: DiknasCourse.find_by_name(row[:pelajaran].strip).try(:id), 
        academic_year_id: tahun.try(:id), 
        academic_term_id: semesters[row[:semester]-1],
        grade_level_id: row[:grade]
      )

      dc.diknas_converted_items << DiknasConvertedItem.new(
        diknas_conversion_id: conversion.id,
        p_score: row[:np],
        t_score: row[:nt]
      )
    end
  end
end
