require 'rails_helper'

RSpec.describe "diknas_report_cards/edit", type: :view do
  before(:each) do
    @diknas_report_card = assign(:diknas_report_card, DiknasReportCard.create!(
      :student => nil,
      :grade_level => nil,
      :grade_section => nil,
      :academic_year => nil,
      :academic_term => nil,
      :course_belongs_to => "MyString",
      :average => 1.5,
      :notes => "MyText"
    ))
  end

  it "renders the edit diknas_report_card form" do
    render

    assert_select "form[action=?][method=?]", diknas_report_card_path(@diknas_report_card), "post" do

      assert_select "input#diknas_report_card_student_id[name=?]", "diknas_report_card[student_id]"

      assert_select "input#diknas_report_card_grade_level_id[name=?]", "diknas_report_card[grade_level_id]"

      assert_select "input#diknas_report_card_grade_section_id[name=?]", "diknas_report_card[grade_section_id]"

      assert_select "input#diknas_report_card_academic_year_id[name=?]", "diknas_report_card[academic_year_id]"

      assert_select "input#diknas_report_card_academic_term_id[name=?]", "diknas_report_card[academic_term_id]"

      assert_select "input#diknas_report_card_course_belongs_to[name=?]", "diknas_report_card[course_belongs_to]"

      assert_select "input#diknas_report_card_average[name=?]", "diknas_report_card[average]"

      assert_select "textarea#diknas_report_card_notes[name=?]", "diknas_report_card[notes]"
    end
  end
end
