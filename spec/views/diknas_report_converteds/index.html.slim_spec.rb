require 'rails_helper'

RSpec.describe "diknas_report_converteds/index", type: :view do
  before(:each) do
    assign(:diknas_report_converteds, [
      DiknasReportConverted.create!(
        :student => nil,
        :academic_year => nil,
        :academic_term => nil,
        :grade_level => nil,
        :notes => "MyText"
      ),
      DiknasReportConverted.create!(
        :student => nil,
        :academic_year => nil,
        :academic_term => nil,
        :grade_level => nil,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of diknas_report_converteds" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
