require 'rails_helper'

RSpec.describe "supplies_transactions/show", type: :view do
  before(:each) do
    @supplies_transaction = assign(:supplies_transaction, SuppliesTransaction.create!(
      :employee => nil,
      :itemcount => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
