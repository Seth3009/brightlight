require 'rails_helper'

RSpec.describe "food_order_items/index", type: :view do
  before(:each) do
    assign(:food_order_items, [
      FoodOrderItem.create!(
        :food_order => nil,
        :food_package => nil,
        :qty_order => 2.5,
        :qty_received => 3.5
      ),
      FoodOrderItem.create!(
        :food_order => nil,
        :food_package => nil,
        :qty_order => 2.5,
        :qty_received => 3.5
      )
    ])
  end

  it "renders a list of food_order_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
  end
end
