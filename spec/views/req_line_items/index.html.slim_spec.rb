require 'rails_helper'

RSpec.describe "req_items/index", type: :view do
  before(:each) do
    assign(:req_items, [
      ReqItem.create!(
        :requisition => "",
        :description, => "Description,",
        :qty_reqd => "",
        :unit, => "Unit,",
        :est_price => "",
        :actual_price => "",
        :currency, => "Currency,",
        :notes, => "Notes,",
        :qty_ordered => "",
        :order_date => "",
        :qty_delivered => "",
        :delivery_date => "",
        :qty_accepted => "",
        :acceptance_date => "",
        :qty_rejected => "",
        :needed_by_date => "",
        :acceptance_notes, => "Acceptance Notes,",
        :reject_notes => "Reject Notes"
      ),
      ReqItem.create!(
        :requisition => "",
        :description, => "Description,",
        :qty_reqd => "",
        :unit, => "Unit,",
        :est_price => "",
        :actual_price => "",
        :currency, => "Currency,",
        :notes, => "Notes,",
        :qty_ordered => "",
        :order_date => "",
        :qty_delivered => "",
        :delivery_date => "",
        :qty_accepted => "",
        :acceptance_date => "",
        :qty_rejected => "",
        :needed_by_date => "",
        :acceptance_notes, => "Acceptance Notes,",
        :reject_notes => "Reject Notes"
      )
    ])
  end

  it "renders a list of req_items" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Unit,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Currency,".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Acceptance Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Reject Notes".to_s, :count => 2
  end
end
