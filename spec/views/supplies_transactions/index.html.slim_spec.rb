require 'rails_helper'

RSpec.describe "supplies_transactions/index", type: :view do
  before(:each) do
    assign(:supplies_transactions, [
      SuppliesTransaction.create!(
        :employee => nil,
        :itemcount => 2
      ),
      SuppliesTransaction.create!(
        :employee => nil,
        :itemcount => 2
      )
    ])
  end

  it "renders a list of supplies_transactions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
