require 'rails_helper'

RSpec.describe "diknas_report_converteds/show", type: :view do
  before(:each) do
    @diknas_report_converted = assign(:diknas_report_converted, DiknasReportConverted.create!(
      :student => nil,
      :academic_year => nil,
      :academic_term => nil,
      :grade_level => nil,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
