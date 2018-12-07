require 'rails_helper'

RSpec.describe "diknas_converteds/edit", type: :view do
  before(:each) do
    @diknas_converted = assign(:diknas_converted, DiknasConverted.create!(
      :student => nil,
      :academic_year => nil,
      :academic_term => nil,
      :grade_level => nil,
      :notes => "MyText"
    ))
  end

  it "renders the edit diknas_converted form" do
    render

    assert_select "form[action=?][method=?]", diknas_converted_path(@diknas_converted), "post" do

      assert_select "input#diknas_converted_student_id[name=?]", "diknas_converted[student_id]"

      assert_select "input#diknas_converted_academic_year_id[name=?]", "diknas_converted[academic_year_id]"

      assert_select "input#diknas_converted_academic_term_id[name=?]", "diknas_converted[academic_term_id]"

      assert_select "input#diknas_converted_grade_level_id[name=?]", "diknas_converted[grade_level_id]"

      assert_select "textarea#diknas_converted_notes[name=?]", "diknas_converted[notes]"
    end
  end
end
