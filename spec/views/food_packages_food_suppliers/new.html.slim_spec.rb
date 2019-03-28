require 'rails_helper'

RSpec.describe "food_packages_food_suppliers/new", type: :view do
  before(:each) do
    assign(:food_packages_food_supplier, FoodPackagesFoodSupplier.new(
      :food_package => nil,
      :food_supplier => nil,
      :price => 1.5
    ))
  end

  it "renders new food_packages_food_supplier form" do
    render

    assert_select "form[action=?][method=?]", food_packages_food_suppliers_path, "post" do

      assert_select "input#food_packages_food_supplier_food_package_id[name=?]", "food_packages_food_supplier[food_package_id]"

      assert_select "input#food_packages_food_supplier_food_supplier_id[name=?]", "food_packages_food_supplier[food_supplier_id]"

      assert_select "input#food_packages_food_supplier_price[name=?]", "food_packages_food_supplier[price]"
    end
  end
end
