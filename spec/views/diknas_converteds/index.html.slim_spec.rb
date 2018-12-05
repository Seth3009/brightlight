require 'rails_helper'

RSpec.describe "diknas_converteds/index", type: :view do
  before(:each) do
    assign(:diknas_converteds, [
      DiknasConverted.create!(
        :student => nil,
        :academic_year => nil,
        :academic_term => nil,
        :grade_level => nil,
        :notes => "MyText"
      ),
      DiknasConverted.create!(
        :student => nil,
        :academic_year => nil,
        :academic_term => nil,
        :grade_level => nil,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of diknas_converteds" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
