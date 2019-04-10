require 'rails_helper'

RSpec.describe "food_packages/edit", type: :view do
  before(:each) do
    @food_package = assign(:food_package, FoodPackage.create!(
      :packaging => "MyString",
      :qty => 1.5,
      :unit => "MyString"
    ))
  end

  it "renders the edit food_package form" do
    render

    assert_select "form[action=?][method=?]", food_package_path(@food_package), "post" do

      assert_select "input#food_package_packaging[name=?]", "food_package[packaging]"

      assert_select "input#food_package_qty[name=?]", "food_package[qty]"

      assert_select "input#food_package_unit[name=?]", "food_package[unit]"
    end
  end
end
