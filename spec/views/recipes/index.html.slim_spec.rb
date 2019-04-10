require 'rails_helper'

RSpec.describe "recipes/index", type: :view do
  before(:each) do
    assign(:recipes, [
      Recipe.create!(
        :food => nil,
        :raw_food => nil,
        :recipe_portion => 2,
        :qty => 3.5,
        :custom_size => 4.5,
        :size_divider => 5.5,
        :portion_size => 6.5,
        :gr1_portion => 7.5,
        :gr2_portion => 8.5,
        :sol_portion => 9.5,
        :sor_portion => 10.5,
        :adult_portion => 11.5
      ),
      Recipe.create!(
        :food => nil,
        :raw_food => nil,
        :recipe_portion => 2,
        :qty => 3.5,
        :custom_size => 4.5,
        :size_divider => 5.5,
        :portion_size => 6.5,
        :gr1_portion => 7.5,
        :gr2_portion => 8.5,
        :sol_portion => 9.5,
        :sor_portion => 10.5,
        :adult_portion => 11.5
      )
    ])
  end

  it "renders a list of recipes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
    assert_select "tr>td", :text => 10.5.to_s, :count => 2
    assert_select "tr>td", :text => 11.5.to_s, :count => 2
  end
end
