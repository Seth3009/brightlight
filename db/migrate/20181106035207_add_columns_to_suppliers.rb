class AddColumnsToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :fax, :string
    add_column :suppliers, :acctg_contact_name, :string
    add_column :suppliers, :acctg_phone, :string
    add_column :suppliers, :acctg_mobile, :string
    add_column :suppliers, :phone2, :string
    add_column :suppliers, :mobile2, :string
    add_column :suppliers, :bank, :string
    add_column :suppliers, :bank_branch, :string
    add_column :suppliers, :bank_acct_name, :string
    add_column :suppliers, :bank_acct_no, :string
    add_column :suppliers, :bank2, :string
    add_column :suppliers, :bank2_branch, :string
    add_column :suppliers, :bank2_acct_name, :string
    add_column :suppliers, :bank2_acct_no, :string
    add_column :suppliers, :payment_method, :string
  end
end
