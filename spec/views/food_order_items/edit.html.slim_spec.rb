require 'rails_helper'

RSpec.describe "food_order_items/edit", type: :view do
  before(:each) do
    @food_order_item = assign(:food_order_item, FoodOrderItem.create!(
      :food_order => nil,
      :food_package => nil,
      :qty_order => 1.5,
      :qty_received => 1.5
    ))
  end

  it "renders the edit food_order_item form" do
    render

    assert_select "form[action=?][method=?]", food_order_item_path(@food_order_item), "post" do

      assert_select "input#food_order_item_food_order_id[name=?]", "food_order_item[food_order_id]"

      assert_select "input#food_order_item_food_package_id[name=?]", "food_order_item[food_package_id]"

      assert_select "input#food_order_item_qty_order[name=?]", "food_order_item[qty_order]"

      assert_select "input#food_order_item_qty_received[name=?]", "food_order_item[qty_received]"
    end
  end
end
