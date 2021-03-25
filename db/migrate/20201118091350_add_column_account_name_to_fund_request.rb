class AddColumnAccountNameToFundRequest < ActiveRecord::Migration
  def change
    add_column :fund_requests, :is_submitted, :boolean, :null => false, :default => false
    add_column :fund_requests, :date_submitted, :date
    add_column :fund_requests, :is_fin_canceled, :boolean, :null => false, :default => false 
    add_column :fund_requests, :is_employee_canceled, :boolean, :null => false, :default => false
  end
end
