class AccountDepartment < ActiveRecord::Base
  belongs_to :account
  belongs_to :department
end
