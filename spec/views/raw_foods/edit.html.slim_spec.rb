require 'rails_helper'

RSpec.describe "raw_foods/edit", type: :view do
  before(:each) do
    @raw_food = assign(:raw_food, RawFood.create!(
      :name => "MyString",
      :is_stock => false
    ))
  end

  it "renders the edit raw_food form" do
    render

    assert_select "form[action=?][method=?]", raw_food_path(@raw_food), "post" do

      assert_select "input#raw_food_name[name=?]", "raw_food[name]"

      assert_select "input#raw_food_is_stock[name=?]", "raw_food[is_stock]"
    end
  end
end
