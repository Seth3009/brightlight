require 'rails_helper'

RSpec.describe "food_orders/index", type: :view do
  before(:each) do
    assign(:food_orders, [
      FoodOrder.create!(
        :order_notes => "Order Notes",
        :food_supplier => nil,
        :is_completed => false
      ),
      FoodOrder.create!(
        :order_notes => "Order Notes",
        :food_supplier => nil,
        :is_completed => false
      )
    ])
  end

  it "renders a list of food_orders" do
    render
    assert_select "tr>td", :text => "Order Notes".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
