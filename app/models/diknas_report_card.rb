class DiknasReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :academic_term

  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('Sheet1')

    header = {student_id: "School UD ID", grade: "Grade", course: "Course",
      gradesection: "Class", average: "S1Avg", school_year: "School Year", academic_term: "Academic term"}
    
    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1
      
        # puts "Department: #{row[:department]}"
        student = Student.find_by_student_no(row[:student_id])
        # grade = Grade.find_by_student_no
        # budget_holder = dept.manager
        # academic_year = AcademicYear.find_by_name(row[:year])

        diknasreportcard = DiknasReportCard.new(
          student_id:       student.id,
          grade_level_id:   row[:grade]
          # budget_holder_id: dept.manager_id,
          # total_amt:        0
        )

        diknasreportcard.save
      

    #   MONTHS.each do |month, month_no|
    #     if row[month].present?
    #       budget_item = BudgetItem.new(
    #         account:            row[:account],
    #         year:               month_no < 7 ? academic_year.end_date.year : academic_year.start_date.year,
    #         line:               i,
    #         description:        row[:description],
    #         month:              month_no,
    #         amount:             row[month],
    #         budget_id:          budget.id
    #       )
    #       budget_item.save
    #       total += budget_item.amount
    #     end 
    #   end       
    # end
    # budget.update_attributes total_amt: total
    # return diknas_report_cards_url
  end 
end
end
