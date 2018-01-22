require 'rails_helper'

RSpec.describe "item_units/new", type: :view do
  before(:each) do
    assign(:item_unit, ItemUnit.new(
      :name => "MyString"
    ))
  end

  it "renders new item_unit form" do
    render

    assert_select "form[action=?][method=?]", item_units_path, "post" do

      assert_select "input#item_unit_name[name=?]", "item_unit[name]"
    end
  end
end
