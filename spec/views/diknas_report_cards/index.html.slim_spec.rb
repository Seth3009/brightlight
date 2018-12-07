require 'rails_helper'

RSpec.describe "diknas_report_cards/index", type: :view do
  before(:each) do
    assign(:diknas_report_cards, [
      DiknasReportCard.create!(
        :student => nil,
        :grade_level => nil,
        :grade_section => nil,
        :academic_year => nil,
        :academic_term => nil,
        :course_belongs_to => "Course Belongs To",
        :average => 2.5,
        :notes => "MyText"
      ),
      DiknasReportCard.create!(
        :student => nil,
        :grade_level => nil,
        :grade_section => nil,
        :academic_year => nil,
        :academic_term => nil,
        :course_belongs_to => "Course Belongs To",
        :average => 2.5,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of diknas_report_cards" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Course Belongs To".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
