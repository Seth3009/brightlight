require 'rails_helper'

RSpec.describe "diknas_report_cards/show", type: :view do
  before(:each) do
    @diknas_report_card = assign(:diknas_report_card, DiknasReportCard.create!(
      :student => nil,
      :grade_level => nil,
      :grade_section => nil,
      :academic_year => nil,
      :academic_term => nil,
      :course_belongs_to => "Course Belongs To",
      :average => 2.5,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Course Belongs To/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/MyText/)
  end
end
