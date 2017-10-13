require 'rails_helper'

RSpec.describe "stock_items/index", type: :view do
  before(:each) do
    assign(:stock_items, [
      StockItem.create!(
        :name, => "Name,",
        :code, => "Code,",
        :description, => "Description,",
        :tags, => "Tags,",
        :short_desc, => "Short Desc,",
        :is_active => "",
        :unit_price => "",
        :image => "",
        :stock_category => "",
        :class, => "Class,",
        :group, => "Group,",
        :weight, => "Weight,",
        :extra1, => "Extra1,",
        :extra2 => "Extra2"
      ),
      StockItem.create!(
        :name, => "Name,",
        :code, => "Code,",
        :description, => "Description,",
        :tags, => "Tags,",
        :short_desc, => "Short Desc,",
        :is_active => "",
        :unit_price => "",
        :image => "",
        :stock_category => "",
        :class, => "Class,",
        :group, => "Group,",
        :weight, => "Weight,",
        :extra1, => "Extra1,",
        :extra2 => "Extra2"
      )
    ])
  end

  it "renders a list of stock_items" do
    render
    assert_select "tr>td", :text => "Name,".to_s, :count => 2
    assert_select "tr>td", :text => "Code,".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "Tags,".to_s, :count => 2
    assert_select "tr>td", :text => "Short Desc,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Class,".to_s, :count => 2
    assert_select "tr>td", :text => "Group,".to_s, :count => 2
    assert_select "tr>td", :text => "Weight,".to_s, :count => 2
    assert_select "tr>td", :text => "Extra1,".to_s, :count => 2
    assert_select "tr>td", :text => "Extra2".to_s, :count => 2
  end
end
