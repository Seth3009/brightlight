require 'rails_helper'

RSpec.describe "purchase_receives/index", type: :view do
  before(:each) do
    assign(:purchase_receives, [
      PurchaseReceive.create!(
        :purchase_order => nil,
        :receiver_id => 2,
        :checker_id => 3,
        :notes => "Notes",
        :partial => false,
        :status => "Status"
      ),
      PurchaseReceive.create!(
        :purchase_order => nil,
        :receiver_id => 2,
        :checker_id => 3,
        :notes => "Notes",
        :partial => false,
        :status => "Status"
      )
    ])
  end

  it "renders a list of purchase_receives" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
