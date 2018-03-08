require 'rails_helper'

RSpec.describe "supplies_transaction_items/show", type: :view do
  before(:each) do
    @supplies_transaction_item = assign(:supplies_transaction_item, SuppliesTransactionItem.create!(
      :supplies_transaction => nil,
      :product => nil,
      :in_out => "In Out",
      :qty => 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/In Out/)
    expect(rendered).to match(/2.5/)
  end
end
