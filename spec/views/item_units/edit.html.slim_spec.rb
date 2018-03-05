require 'rails_helper'

RSpec.describe "item_units/edit", type: :view do
  before(:each) do
    @item_unit = assign(:item_unit, ItemUnit.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit item_unit form" do
    render

    assert_select "form[action=?][method=?]", item_unit_path(@item_unit), "post" do

      assert_select "input#item_unit_name[name=?]", "item_unit[name]"
    end
  end
end
