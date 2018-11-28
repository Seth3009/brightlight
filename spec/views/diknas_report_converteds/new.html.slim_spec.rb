require 'rails_helper'

RSpec.describe "diknas_report_converteds/new", type: :view do
  before(:each) do
    assign(:diknas_report_converted, DiknasReportConverted.new(
      :student => nil,
      :academic_year => nil,
      :academic_term => nil,
      :grade_level => nil,
      :notes => "MyText"
    ))
  end

  it "renders new diknas_report_converted form" do
    render

    assert_select "form[action=?][method=?]", diknas_report_converteds_path, "post" do

      assert_select "input#diknas_report_converted_student_id[name=?]", "diknas_report_converted[student_id]"

      assert_select "input#diknas_report_converted_academic_year_id[name=?]", "diknas_report_converted[academic_year_id]"

      assert_select "input#diknas_report_converted_academic_term_id[name=?]", "diknas_report_converted[academic_term_id]"

      assert_select "input#diknas_report_converted_grade_level_id[name=?]", "diknas_report_converted[grade_level_id]"

      assert_select "textarea#diknas_report_converted_notes[name=?]", "diknas_report_converted[notes]"
    end
  end
end
