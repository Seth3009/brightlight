class Account < ActiveRecord::Base
  has_many :account_departments, dependent: :destroy
  has_many :departments, through: :account_departments
  has_many :requisitions

  scope :for_department_id, lambda {|id| 
    joins(:departments).where(departments: {id: id}) 
    .where.not(acc_l4: nil)
  }

  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('accounts')

    header = {acc_l1: "acc_l1", acc_l2: "acc_l2", acc_l3: "acc_l3", acc_l4: "acc_l4", description: "description",
      dept1: "dept1", dept2: "dept2", notes: "notes"
    }

    sheet.each_with_index(header) do |row,i|
      next if i < 1
      
      dept1 = Department.find_by_code(row[:dept1]) if row[:dept1]
      dept2 = Department.find_by_code(row[:dept2]) if row[:dept2]
      puts "#{i}, Account: #{row[:description]} (#{dept1.try(:name)} #{dept2.try(:name)})"
      account = Account.new(
        acc_l1: row[:acc_l1],
        acc_l2: row[:acc_l2],
        acc_l3: row[:acc_l3],
        acc_l4: row[:acc_l4],
        description: row[:description],
        notes: row[:notes]
      )
      account.departments << dept1 if dept1.present?
      account.departments << dept2 if dept2.present?
      account.save     
    end
  end 

end
