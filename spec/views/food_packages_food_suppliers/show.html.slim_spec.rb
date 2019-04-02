require 'rails_helper'

RSpec.describe "food_packages_food_suppliers/show", type: :view do
  before(:each) do
    @food_packages_food_supplier = assign(:food_packages_food_supplier, FoodPackagesFoodSupplier.create!(
      :food_package => nil,
      :food_supplier => nil,
      :price => 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
  end
end
