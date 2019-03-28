require 'rails_helper'

RSpec.describe "food_packages_food_suppliers/index", type: :view do
  before(:each) do
    assign(:food_packages_food_suppliers, [
      FoodPackagesFoodSupplier.create!(
        :food_package => nil,
        :food_supplier => nil,
        :price => 2.5
      ),
      FoodPackagesFoodSupplier.create!(
        :food_package => nil,
        :food_supplier => nil,
        :price => 2.5
      )
    ])
  end

  it "renders a list of food_packages_food_suppliers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
  end
end
