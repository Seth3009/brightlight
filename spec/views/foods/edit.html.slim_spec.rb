require 'rails_helper'

RSpec.describe "foods/edit", type: :view do
  before(:each) do
    @food = assign(:food, Food.create!(
      :name => "MyString",
      :ingredients => 1,
      :is_active => false
    ))
  end

  it "renders the edit food form" do
    render

    assert_select "form[action=?][method=?]", food_path(@food), "post" do

      assert_select "input#food_name[name=?]", "food[name]"

      assert_select "input#food_ingredients[name=?]", "food[ingredients]"

      assert_select "input#food_is_active[name=?]", "food[is_active]"
    end
  end
end
