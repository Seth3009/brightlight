require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :code => "Code",
        :name => "Name",
        :price => "9.99",
        :min_stock => 2.5,
        :max_stock => 3.5,
        :stock_type => "Stock Type",
        :item_unit => nil,
        :item_category => nil,
        :is_active => false,
        :img_url => "Img Url"
      ),
      Product.create!(
        :code => "Code",
        :name => "Name",
        :price => "9.99",
        :min_stock => 2.5,
        :max_stock => 3.5,
        :stock_type => "Stock Type",
        :item_unit => nil,
        :item_category => nil,
        :is_active => false,
        :img_url => "Img Url"
      )
    ])
  end

  it "renders a list of products" do
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
    assert_select "tr>td", :text => "Img Url".to_s, :count => 2
  end
end
