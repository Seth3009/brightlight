require 'rails_helper'

RSpec.describe "food_packages/show", type: :view do
  before(:each) do
    @food_package = assign(:food_package, FoodPackage.create!(
      :packaging => "Packaging",
      :qty => 2.5,
      :unit => "Unit"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Packaging/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Unit/)
  end
end
