require 'rails_helper'

RSpec.describe "order_items/index", type: :view do
  before(:each) do
    assign(:order_items, [
      OrderItem.create!(
        :purchase_order => "",
        :stock_item => "",
        :quantity => "",
        :unit, => "Unit,",
        :min_delivery_qty => "",
        :pending_qty => "",
        :type, => "Type,",
        :line_amount => "",
        :unit_price => "",
        :currency, => "Currency,",
        :deleted => "",
        :description, => "Description,",
        :status, => "Status,",
        :line_num => "",
        :extra1, => "Extra1,",
        :extra2 => "Extra2"
      ),
      OrderItem.create!(
        :purchase_order => "",
        :stock_item => "",
        :quantity => "",
        :unit, => "Unit,",
        :min_delivery_qty => "",
        :pending_qty => "",
        :type, => "Type,",
        :line_amount => "",
        :unit_price => "",
        :currency, => "Currency,",
        :deleted => "",
        :description, => "Description,",
        :status, => "Status,",
        :line_num => "",
        :extra1, => "Extra1,",
        :extra2 => "Extra2"
      )
    ])
  end

  it "renders a list of order_items" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Unit,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Currency,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "Status,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Extra1,".to_s, :count => 2
    assert_select "tr>td", :text => "Extra2".to_s, :count => 2
  end
end
