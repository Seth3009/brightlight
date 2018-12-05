require 'rails_helper'

RSpec.describe "diknas_converted_items/index", type: :view do
  before(:each) do
    assign(:diknas_converted_items, [
      DiknasConvertedItem.create!(
        :diknas_converted => nil,
        :diknas_conversion => nil,
        :P_score => 2.5,
        :T_score => 3.5,
        :comment => "MyText"
      ),
      DiknasConvertedItem.create!(
        :diknas_converted => nil,
        :diknas_conversion => nil,
        :P_score => 2.5,
        :T_score => 3.5,
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of diknas_converted_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
