require 'rails_helper'

RSpec.describe "food_orders/show", type: :view do
  before(:each) do
    @food_order = assign(:food_order, FoodOrder.create!(
      :order_notes => "Order Notes",
      :food_supplier => nil,
      :is_completed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Order Notes/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
