require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :code => "Code",
      :name => "Name",
      :price => "9.99",
      :min_stock => 2.5,
      :max_stock => 3.5,
      :stock_type => "Stock Type",
      :item_unit => nil,
      :item_category => nil,
      :is_active => false,
      :img_url => "Img Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Stock Type/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Img Url/)
  end
end
