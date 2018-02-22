require 'rails_helper'

RSpec.describe "supplies/index", type: :view do
  before(:each) do
    assign(:supplies, [
      Supply.create!(
        :code => "Code",
        :name => "Name",
        :price => "9.99",
        :min_stock => 2.5,
        :max_stock => 3.5,
        :stock_type => "Stock Type",
        :item_unit => nil,
        :item_category => nil,
        :supply_status => false
      ),
      Supply.create!(
        :code => "Code",
        :name => "Name",
        :price => "9.99",
        :min_stock => 2.5,
        :max_stock => 3.5,
        :stock_type => "Stock Type",
        :item_unit => nil,
        :item_category => nil,
        :supply_status => false
      )
    ])
  end

  it "renders a list of supplies" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Stock Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
