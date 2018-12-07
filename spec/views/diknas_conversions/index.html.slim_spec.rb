require 'rails_helper'

RSpec.describe "diknas_conversions/index", type: :view do
  before(:each) do
    assign(:diknas_conversions, [
      DiknasConversion.create!(
        :course => nil,
        :diknas_course => nil,
        :academic_year => nil,
        :academic_term => nil,
        :weight => 2.5,
        :notes => "MyText"
      ),
      DiknasConversion.create!(
        :course => nil,
        :diknas_course => nil,
        :academic_year => nil,
        :academic_term => nil,
        :weight => 2.5,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of diknas_conversions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
