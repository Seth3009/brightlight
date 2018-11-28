require 'rails_helper'

RSpec.describe "diknas_converted_items/edit", type: :view do
  before(:each) do
    @diknas_converted_item = assign(:diknas_converted_item, DiknasConvertedItem.create!(
      :diknas_converted => nil,
      :diknas_conversion => nil,
      :P_score => 1.5,
      :T_score => 1.5,
      :comment => "MyText"
    ))
  end

  it "renders the edit diknas_converted_item form" do
    render

    assert_select "form[action=?][method=?]", diknas_converted_item_path(@diknas_converted_item), "post" do

      assert_select "input#diknas_converted_item_diknas_converted_id[name=?]", "diknas_converted_item[diknas_converted_id]"

      assert_select "input#diknas_converted_item_diknas_conversion_id[name=?]", "diknas_converted_item[diknas_conversion_id]"

      assert_select "input#diknas_converted_item_P_score[name=?]", "diknas_converted_item[P_score]"

      assert_select "input#diknas_converted_item_T_score[name=?]", "diknas_converted_item[T_score]"

      assert_select "textarea#diknas_converted_item_comment[name=?]", "diknas_converted_item[comment]"
    end
  end
end
