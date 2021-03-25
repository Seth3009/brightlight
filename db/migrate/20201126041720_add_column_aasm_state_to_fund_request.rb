class AddColumnAasmStateToFundRequest < ActiveRecord::Migration
  def change
    add_column :fund_requests, :aasm_state, :string
  end
end
