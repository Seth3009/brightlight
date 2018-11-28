require 'rails_helper'

RSpec.describe "diknas_report_converted_items/new", type: :view do
  before(:each) do
    assign(:diknas_report_converted_item, DiknasReportConvertedItem.new(
      :diknas_report_converted => nil,
      :diknas_conversion => nil,
      :P_score => 1.5,
      :T_score => 1.5,
      :comment => "MyText"
    ))
  end

  it "renders new diknas_report_converted_item form" do
    render

    assert_select "form[action=?][method=?]", diknas_report_converted_items_path, "post" do

      assert_select "input#diknas_report_converted_item_diknas_report_converted_id[name=?]", "diknas_report_converted_item[diknas_report_converted_id]"

      assert_select "input#diknas_report_converted_item_diknas_conversion_id[name=?]", "diknas_report_converted_item[diknas_conversion_id]"

      assert_select "input#diknas_report_converted_item_P_score[name=?]", "diknas_report_converted_item[P_score]"

      assert_select "input#diknas_report_converted_item_T_score[name=?]", "diknas_report_converted_item[T_score]"

      assert_select "textarea#diknas_report_converted_item_comment[name=?]", "diknas_report_converted_item[comment]"
    end
  end
end
