require 'rails_helper'

RSpec.describe "purchase_receives/show", type: :view do
  before(:each) do
    @purchase_receive = assign(:purchase_receive, PurchaseReceive.create!(
      :purchase_order => nil,
      :receiver_id => 2,
      :checker_id => 3,
      :notes => "Notes",
      :partial => false,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Status/)
  end
end
