require 'rails_helper'

RSpec.describe "warehouses/new", type: :view do
  before(:each) do
    assign(:warehouse, Warehouse.new(
      :name => "MyString",
      :room_number => "MyString"
    ))
  end

  it "renders new warehouse form" do
    render

    assert_select "form[action=?][method=?]", warehouses_path, "post" do

      assert_select "input#warehouse_name[name=?]", "warehouse[name]"

      assert_select "input#warehouse_room_number[name=?]", "warehouse[room_number]"
    end
  end
end
