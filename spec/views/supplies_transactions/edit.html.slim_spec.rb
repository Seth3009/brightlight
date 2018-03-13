require 'rails_helper'

RSpec.describe "supplies_transactions/edit", type: :view do
  before(:each) do
    @supplies_transaction = assign(:supplies_transaction, SuppliesTransaction.create!(
      :employee => nil,
      :itemcount => 1
    ))
  end

  it "renders the edit supplies_transaction form" do
    render

    assert_select "form[action=?][method=?]", supplies_transaction_path(@supplies_transaction), "post" do

      assert_select "input#supplies_transaction_employee_id[name=?]", "supplies_transaction[employee_id]"

      assert_select "input#supplies_transaction_itemcount[name=?]", "supplies_transaction[itemcount]"
    end
  end
end
