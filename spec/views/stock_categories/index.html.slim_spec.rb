require 'rails_helper'

RSpec.describe "stock_categories/index", type: :view do
  before(:each) do
    assign(:stock_categories, [
      StockCategory.create!(
        :name, => "Name,",
        :code, => "Code,",
        :description, => "Description,",
        :type, => "Type,",
        :is_active => "",
        :location => "Location"
      ),
      StockCategory.create!(
        :name, => "Name,",
        :code, => "Code,",
        :description, => "Description,",
        :type, => "Type,",
        :is_active => "",
        :location => "Location"
      )
    ])
  end

  it "renders a list of stock_categories" do
    render
    assert_select "tr>td", :text => "Name,".to_s, :count => 2
    assert_select "tr>td", :text => "Code,".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
