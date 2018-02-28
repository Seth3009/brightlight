require 'rails_helper'

RSpec.describe "warehouses/edit", type: :view do
  before(:each) do
    @warehouse = assign(:warehouse, Warehouse.create!(
      :name => "MyString",
      :room_number => "MyString"
    ))
  end

  it "renders the edit warehouse form" do
    render

    assert_select "form[action=?][method=?]", warehouse_path(@warehouse), "post" do

      assert_select "input#warehouse_name[name=?]", "warehouse[name]"

      assert_select "input#warehouse_room_number[name=?]", "warehouse[room_number]"
    end
  end
end
