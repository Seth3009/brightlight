require 'rails_helper'

RSpec.describe "food_delivery_items/index", type: :view do
  before(:each) do
    assign(:food_delivery_items, [
      FoodDeliveryItem.create!(
        :food_delivery => nil,
        :food_package => nil,
        :qty => 2.5
      ),
      FoodDeliveryItem.create!(
        :food_delivery => nil,
        :food_package => nil,
        :qty => 2.5
      )
    ])
  end

  it "renders a list of food_delivery_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
  end
end
