require 'rails_helper'

RSpec.describe "food_packages/index", type: :view do
  before(:each) do
    assign(:food_packages, [
      FoodPackage.create!(
        :packaging => "Packaging",
        :qty => 2.5,
        :unit => "Unit"
      ),
      FoodPackage.create!(
        :packaging => "Packaging",
        :qty => 2.5,
        :unit => "Unit"
      )
    ])
  end

  it "renders a list of food_packages" do
    render
    assert_select "tr>td", :text => "Packaging".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Unit".to_s, :count => 2
  end
end
