require 'rails_helper'

RSpec.describe "supplies_transactions/new", type: :view do
  before(:each) do
    assign(:supplies_transaction, SuppliesTransaction.new(
      :employee => nil,
      :itemcount => 1
    ))
  end

  it "renders new supplies_transaction form" do
    render

    assert_select "form[action=?][method=?]", supplies_transactions_path, "post" do

      assert_select "input#supplies_transaction_employee_id[name=?]", "supplies_transaction[employee_id]"

      assert_select "input#supplies_transaction_itemcount[name=?]", "supplies_transaction[itemcount]"
    end
  end
end
