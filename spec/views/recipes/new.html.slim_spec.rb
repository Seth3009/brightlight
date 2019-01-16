require 'rails_helper'

RSpec.describe "recipes/new", type: :view do
  before(:each) do
    assign(:recipe, Recipe.new(
      :food => nil,
      :raw_food => nil,
      :recipe_portion => 1,
      :qty => 1.5,
      :custom_size => 1.5,
      :size_divider => 1.5,
      :portion_size => 1.5,
      :gr1_portion => 1.5,
      :gr2_portion => 1.5,
      :sol_portion => 1.5,
      :sor_portion => 1.5,
      :adult_portion => 1.5
    ))
  end

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do

      assert_select "input#recipe_food_id[name=?]", "recipe[food_id]"

      assert_select "input#recipe_raw_food_id[name=?]", "recipe[raw_food_id]"

      assert_select "input#recipe_recipe_portion[name=?]", "recipe[recipe_portion]"

      assert_select "input#recipe_qty[name=?]", "recipe[qty]"

      assert_select "input#recipe_custom_size[name=?]", "recipe[custom_size]"

      assert_select "input#recipe_size_divider[name=?]", "recipe[size_divider]"

      assert_select "input#recipe_portion_size[name=?]", "recipe[portion_size]"

      assert_select "input#recipe_gr1_portion[name=?]", "recipe[gr1_portion]"

      assert_select "input#recipe_gr2_portion[name=?]", "recipe[gr2_portion]"

      assert_select "input#recipe_sol_portion[name=?]", "recipe[sol_portion]"

      assert_select "input#recipe_sor_portion[name=?]", "recipe[sor_portion]"

      assert_select "input#recipe_adult_portion[name=?]", "recipe[adult_portion]"
    end
  end
end
