require 'rails_helper'

RSpec.describe "food_order_items/new", type: :view do
  before(:each) do
    assign(:food_order_item, FoodOrderItem.new(
      :food_order => nil,
      :food_package => nil,
      :qty_order => 1.5,
      :qty_received => 1.5
    ))
  end

  it "renders new food_order_item form" do
    render

    assert_select "form[action=?][method=?]", food_order_items_path, "post" do

      assert_select "input#food_order_item_food_order_id[name=?]", "food_order_item[food_order_id]"

      assert_select "input#food_order_item_food_package_id[name=?]", "food_order_item[food_package_id]"

      assert_select "input#food_order_item_qty_order[name=?]", "food_order_item[qty_order]"

      assert_select "input#food_order_item_qty_received[name=?]", "food_order_item[qty_received]"
    end
  end
end
