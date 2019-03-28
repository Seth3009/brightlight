require 'rails_helper'

RSpec.describe "food_deliveries/show", type: :view do
  before(:each) do
    @food_delivery = assign(:food_delivery, FoodDelivery.create!(
      :deliver_to => "Deliver To",
      :notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Deliver To/)
    expect(rendered).to match(/Notes/)
  end
end
