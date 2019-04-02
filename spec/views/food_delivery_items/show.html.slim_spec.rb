require 'rails_helper'

RSpec.describe "food_delivery_items/show", type: :view do
  before(:each) do
    @food_delivery_item = assign(:food_delivery_item, FoodDeliveryItem.create!(
      :food_delivery => nil,
      :food_package => nil,
      :qty => 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
  end
end
