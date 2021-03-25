class AddColumnStatusToFundRequest < ActiveRecord::Migration
  def change
    add_column :fund_requests, :status, :string
  end
end
