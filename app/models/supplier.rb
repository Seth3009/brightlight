class Supplier < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  has_many :purchase_orders
  
  validates :company_name, presence: true

  def self.import_xlsx(file_path)
    # Read from file
    xl = Roo::Spreadsheet.open(file_path)
    sheet = xl.sheet('suppliers')

    header = {
      company_name: "company_name",	address1: "address1",	address2: "address2",	city: "city",	province: "province",
      post_code: "post_code", country: "country",	category: "category", email: "email", website: "website",	phone: "phone",
      phone2: "phone2", fax: "fax", contact_name: "contact_name",  mobile: "mobile", mobile2: "mobile2", acctg_contact_name: "acctg_contact_name",
      acctg_phone: "acctg_phone", payment_method: "payment_method", bank: "bank", bank_branch: "bank_branch", bank_acct_name: "bank_acct_name",
      bank_acct_no: "bank_acct_no", bank2: "bank2", bank2_branch: "bank2_branch", bank2_acct_name: "bank2_acct_name", bank2_acct_no: "bank2_acct_no"
    }

    sheet.each_with_index(header) do |row,i|
      next if i < 1
      
      supplier = Supplier.new(
        header.reduce({}) { |acc, v| acc.merge(v.first => row[v.last.to_sym]) }
      )
      puts "#{i} Supplier: #{supplier.company_name}"
      supplier.save     
    end
  end 
end
