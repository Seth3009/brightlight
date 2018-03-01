require 'rails_helper'

RSpec.describe "supplies_stocks/index", type: :view do
  before(:each) do
    assign(:supplies_stocks, [
      SuppliesStock.create!(
        :trx_type => "Trx Type",
        :qty => 2.5,
        :trx_notes => "Trx Notes",
        :supply => nil,
        :user => nil,
        :warehouse => nil
      ),
      SuppliesStock.create!(
        :trx_type => "Trx Type",
        :qty => 2.5,
        :trx_notes => "Trx Notes",
        :supply => nil,
        :user => nil,
        :warehouse => nil
      )
    ])
  end

  it "renders a list of supplies_stocks" do
    render
    assert_select "tr>td", :text => "Trx Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Trx Notes".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
