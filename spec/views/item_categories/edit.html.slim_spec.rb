require 'rails_helper'

RSpec.describe "item_categories/edit", type: :view do
  before(:each) do
    @item_category = assign(:item_category, ItemCategory.create!(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit item_category form" do
    render

    assert_select "form[action=?][method=?]", item_category_path(@item_category), "post" do

      assert_select "input#item_category_code[name=?]", "item_category[code]"

      assert_select "input#item_category_name[name=?]", "item_category[name]"
    end
  end
end
