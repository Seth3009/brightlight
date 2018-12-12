require 'rails_helper'

RSpec.describe "diknas_conversion_items/index", type: :view do
  before(:each) do
    assign(:diknas_conversion_items, [
      DiknasConversionItem.create!(
        :diknas_conversion => nil,
        :course => nil,
        :academic_year => nil,
        :academic_term => nil,
        :weight => 2,
        :notes => "MyText"
      ),
      DiknasConversionItem.create!(
        :diknas_conversion => nil,
        :course => nil,
        :academic_year => nil,
        :academic_term => nil,
        :weight => 2,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of diknas_conversion_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
