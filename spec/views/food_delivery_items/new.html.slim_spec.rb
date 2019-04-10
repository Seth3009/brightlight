require 'rails_helper'

RSpec.describe "food_delivery_items/new", type: :view do
  before(:each) do
    assign(:food_delivery_item, FoodDeliveryItem.new(
      :food_delivery => nil,
      :food_package => nil,
      :qty => 1.5
    ))
  end

  it "renders new food_delivery_item form" do
    render

    assert_select "form[action=?][method=?]", food_delivery_items_path, "post" do

      assert_select "input#food_delivery_item_food_delivery_id[name=?]", "food_delivery_item[food_delivery_id]"

      assert_select "input#food_delivery_item_food_package_id[name=?]", "food_delivery_item[food_package_id]"

      assert_select "input#food_delivery_item_qty[name=?]", "food_delivery_item[qty]"
    end
  end
end
