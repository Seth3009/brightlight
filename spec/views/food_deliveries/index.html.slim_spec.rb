require 'rails_helper'

RSpec.describe "food_deliveries/index", type: :view do
  before(:each) do
    assign(:food_deliveries, [
      FoodDelivery.create!(
        :deliver_to => "Deliver To",
        :notes => "Notes"
      ),
      FoodDelivery.create!(
        :deliver_to => "Deliver To",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of food_deliveries" do
    render
    assert_select "tr>td", :text => "Deliver To".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
