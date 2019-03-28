require 'rails_helper'

RSpec.describe "raw_foods/new", type: :view do
  before(:each) do
    assign(:raw_food, RawFood.new(
      :name => "MyString",
      :is_stock => false
    ))
  end

  it "renders new raw_food form" do
    render

    assert_select "form[action=?][method=?]", raw_foods_path, "post" do

      assert_select "input#raw_food_name[name=?]", "raw_food[name]"

      assert_select "input#raw_food_is_stock[name=?]", "raw_food[is_stock]"
    end
  end
end
