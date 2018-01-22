require 'rails_helper'

RSpec.describe "item_categories/show", type: :view do
  before(:each) do
    @item_category = assign(:item_category, ItemCategory.create!(
      :code => "Code",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name/)
  end
end
