require 'rails_helper'

RSpec.describe "item_categories/new", type: :view do
  before(:each) do
    assign(:item_category, ItemCategory.new(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new item_category form" do
    render

    assert_select "form[action=?][method=?]", item_categories_path, "post" do

      assert_select "input#item_category_code[name=?]", "item_category[code]"

      assert_select "input#item_category_name[name=?]", "item_category[name]"
    end
  end
end
