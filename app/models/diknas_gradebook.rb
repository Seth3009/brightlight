class DiknasGradebook < ActiveRecord::Base

    def self.import_xlsx(file_path)
        # Read from file
        xl = Roo::Spreadsheet.open(file_path)
        sheet = xl.sheet('Sheet1')
    
        header = {student: "Student", grade: "Grade", gradeclass: "Gradeclass", avg: "Avg", semester: "Semester"}
        puts "Opening #{file_path}"
    
        budget = DiknasGradebook.new
        # total = 0
        # academic_year = ""
    
        # sheet.each_with_index(header) do |row,i|
        #   puts "#{i}, #{row}"
        #   next if i < 1
          
        #   if i == 1
            # puts "Department: #{row[:department]}"
            # dept = Department.find_by_code(row[:department])
            # budget_holder = dept.manager
            # academic_year = AcademicYear.find_by_name(row[:year])
    
            # budget = DiknasGradebook.new(
            #   academic_year_id: academic_year.id,
            #   department_id:    dept.id,
            #   budget_holder_id: dept.manager_id,
            #   total_amt:        0
            # )
    
        #     budget.save
        #   end
    
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
        return budget
      end 
end
