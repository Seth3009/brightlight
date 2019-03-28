require 'rails_helper'

RSpec.describe "food_order_items/show", type: :view do
  before(:each) do
    @food_order_item = assign(:food_order_item, FoodOrderItem.create!(
      :food_order => nil,
      :food_package => nil,
      :qty_order => 2.5,
      :qty_received => 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
  end
end
