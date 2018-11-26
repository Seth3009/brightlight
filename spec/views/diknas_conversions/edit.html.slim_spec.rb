require 'rails_helper'

RSpec.describe "diknas_conversions/edit", type: :view do
  before(:each) do
    @diknas_conversion = assign(:diknas_conversion, DiknasConversion.create!(
      :course => nil,
      :diknas_course => nil,
      :academic_year => nil,
      :academic_term => nil,
      :weight => 1.5,
      :notes => "MyText"
    ))
  end

  it "renders the edit diknas_conversion form" do
    render

    assert_select "form[action=?][method=?]", diknas_conversion_path(@diknas_conversion), "post" do

      assert_select "input#diknas_conversion_course_id[name=?]", "diknas_conversion[course_id]"

      assert_select "input#diknas_conversion_diknas_course_id[name=?]", "diknas_conversion[diknas_course_id]"

      assert_select "input#diknas_conversion_academic_year_id[name=?]", "diknas_conversion[academic_year_id]"

      assert_select "input#diknas_conversion_academic_term_id[name=?]", "diknas_conversion[academic_term_id]"

      assert_select "input#diknas_conversion_weight[name=?]", "diknas_conversion[weight]"

      assert_select "textarea#diknas_conversion_notes[name=?]", "diknas_conversion[notes]"
    end
  end
end
