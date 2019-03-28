require 'rails_helper'

RSpec.describe "foods/new", type: :view do
  before(:each) do
    assign(:food, Food.new(
      :name => "MyString",
      :ingredients => 1,
      :is_active => false
    ))
  end

  it "renders new food form" do
    render

    assert_select "form[action=?][method=?]", foods_path, "post" do

      assert_select "input#food_name[name=?]", "food[name]"

      assert_select "input#food_ingredients[name=?]", "food[ingredients]"

      assert_select "input#food_is_active[name=?]", "food[is_active]"
    end
  end
end
