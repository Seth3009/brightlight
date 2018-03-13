require 'rails_helper'

RSpec.describe "supplies_transaction_items/index", type: :view do
  before(:each) do
    assign(:supplies_transaction_items, [
      SuppliesTransactionItem.create!(
        :supplies_transaction => nil,
        :product => nil,
        :in_out => "In Out",
        :qty => 2.5
      ),
      SuppliesTransactionItem.create!(
        :supplies_transaction => nil,
        :product => nil,
        :in_out => "In Out",
        :qty => 2.5
      )
    ])
  end

  it "renders a list of supplies_transaction_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "In Out".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
  end
end
