require 'rails_helper'

RSpec.describe "raw_foods/show", type: :view do
  before(:each) do
    @raw_food = assign(:raw_food, RawFood.create!(
      :name => "Name",
      :is_stock => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
