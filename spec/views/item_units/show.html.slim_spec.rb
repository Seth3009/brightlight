require 'rails_helper'

RSpec.describe "item_units/show", type: :view do
  before(:each) do
    @item_unit = assign(:item_unit, ItemUnit.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
