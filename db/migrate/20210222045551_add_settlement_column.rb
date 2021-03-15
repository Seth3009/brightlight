class AddSettlementColumn < ActiveRecord::Migration
  def change
    add_column :fund_requests, :is_settled, :boolean , default: false
    add_column :fund_requests, :settlement_date, :date
    add_column :fund_requests, :settlement_code, :string

  end
end
