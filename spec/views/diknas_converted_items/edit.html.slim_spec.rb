require 'rails_helper'

RSpec.describe "diknas_converted_items/edit", type: :view do
  before(:each) do
    @diknas_converted_item = assign(:diknas_converted_item, DiknasConvertedItem.create!(
      :diknas_converted => nil,
      :diknas_conversion => nil,
      :p_score => 1.5,
      :t_score => 1.5,
      :comment => "MyText"
    ))
  end

  it "renders the edit diknas_converted_item form" do
    render

    assert_select "form[action=?][method=?]", diknas_converted_item_path(@diknas_converted_item), "post" do

      assert_select "input#diknas_converted_item_diknas_converted_id[name=?]", "diknas_converted_item[diknas_converted_id]"

      assert_select "input#diknas_converted_item_diknas_conversion_id[name=?]", "diknas_converted_item[diknas_conversion_id]"

      assert_select "input#diknas_converted_item_p_score[name=?]", "diknas_converted_item[p_score]"

      assert_select "input#diknas_converted_item_t_score[name=?]", "diknas_converted_item[t_score]"

      assert_select "textarea#diknas_converted_item_comment[name=?]", "diknas_converted_item[comment]"
    end
  end
end
