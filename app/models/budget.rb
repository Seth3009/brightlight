class Budget < ActiveRecord::Base
  belongs_to :department
  belongs_to :budget_holder, class_name: 'Employee'
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :academic_year
  belongs_to :approver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  has_many  :budget_items, dependent: :destroy
  
  validates :department_id, presence: true
  validates :academic_year_id, presence: true
  validates :total_amt, presence: true

  accepts_nested_attributes_for :budget_items, reject_if: :all_blank, allow_destroy: true

  scope :current, lambda { where(academic_year_id: AcademicYear.current_id) }

  def to_s
    if grade_section
      "#{grade_section.name} - #{academic_year.name}"
    else
      "#{department.name} - #{academic_year.name}"
    end
  end

  MONTHS = {jan: 1, feb: 2, mar: 3, apr: 4, may: 5, jun: 6, jul: 7, aug: 8, sep: 9, oct: 10, nov: 11, dec: 12}

  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('Sheet1')

    header = {account: "Account", description: "Description", year: "Year", department: "Department", interrelated: "Interrelated", total: "Total",
      jan: "Jan", feb: "Feb", mar: "Mar", apr: "Apr", may: "May", jun: "Jun", jul: "Jul", aug: "Aug", sep: "Sep", oct: "Oct",
      nov: "Nov", dec: "Dec"
    }
    puts "Opening #{file_path}"

    budget = Budget.new
    total = 0
    academic_year = ""

    sheet.each_with_index(header) do |row,i|
      puts "#{i}, #{row}"
      next if i < 1
      
      if i == 1
        puts "Department: #{row[:department]}"
        dept = Department.find_by_code(row[:department])
        budget_holder = dept.manager
        academic_year = AcademicYear.find_by_name(row[:year])

        budget = Budget.new(
          academic_year_id: academic_year.id,
          department_id:    dept.id,
          budget_holder_id: dept.manager_id,
          total_amt:        0
        )

        budget.save
      end

      MONTHS.each do |month, month_no|
        if row[month].present?
          budget_item = BudgetItem.new(
            account:            row[:account],
            year:               month_no < 7 ? academic_year.end_date.year : academic_year.start_date.year,
            line:               i,
            description:        row[:description],
            month:              month_no,
            amount:             row[month],
            budget_id:          budget.id
          )
          budget_item.save
          total += budget_item.amount
        end 
      end       
    end
    budget.update_attributes total_amt: total
    return budget
  end 

  def pivot_table
    PivotTable::Grid.new(sort: false) do |g|
      g.source_data  = self.budget_items.order(:line, :year, :month)
      g.column_name  = :month
      g.row_name     = :description
      g.value_name   = :amount
    end.build
  end

  def crosstab
    pivot = budget_items.order(:id).pluck(:description).uniq
    pivot.map { |description|
      budget_items
        .where(description: description)
        .order(:year, :month)
        .select(:year, :month, :amount)
        .reduce([description]) { |memo, x| 
          memo << [x.year, MONTHS.key(x.month).to_s.humanize, x.amount.to_f]
        }
    }
  end 
end
