require 'rails_helper'

RSpec.describe "supplies_stocks/show", type: :view do
  before(:each) do
    @supplies_stock = assign(:supplies_stock, SuppliesStock.create!(
      :trx_type => "Trx Type",
      :qty => 2.5,
      :trx_notes => "Trx Notes",
      :supply => nil,
      :user => nil,
      :warehouse => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Trx Type/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Trx Notes/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
