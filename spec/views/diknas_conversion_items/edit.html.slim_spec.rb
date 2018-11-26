require 'rails_helper'

RSpec.describe "diknas_conversion_items/edit", type: :view do
  before(:each) do
    @diknas_conversion_item = assign(:diknas_conversion_item, DiknasConversionItem.create!(
      :diknas_conversion => nil,
      :course => nil,
      :academic_year => nil,
      :academic_term => nil,
      :weight => 1,
      :notes => "MyText"
    ))
  end

  it "renders the edit diknas_conversion_item form" do
    render

    assert_select "form[action=?][method=?]", diknas_conversion_item_path(@diknas_conversion_item), "post" do

      assert_select "input#diknas_conversion_item_diknas_conversion_id[name=?]", "diknas_conversion_item[diknas_conversion_id]"

      assert_select "input#diknas_conversion_item_course_id[name=?]", "diknas_conversion_item[course_id]"

      assert_select "input#diknas_conversion_item_academic_year_id[name=?]", "diknas_conversion_item[academic_year_id]"

      assert_select "input#diknas_conversion_item_academic_term_id[name=?]", "diknas_conversion_item[academic_term_id]"

      assert_select "input#diknas_conversion_item_weight[name=?]", "diknas_conversion_item[weight]"

      assert_select "textarea#diknas_conversion_item_notes[name=?]", "diknas_conversion_item[notes]"
    end
  end
end
