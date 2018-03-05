require 'rails_helper'

RSpec.describe "delivery_items/index", type: :view do
  before(:each) do
    assign(:delivery_items, [
      DeliveryItem.create!(
        :delivery => "",
        :order_item => "",
        :quantity => "",
        :unit, => "Unit,",
        :accepted_by => "",
        :accepted_date => "",
        :checked_by => "",
        :checked_date, => "Checked Date,",
        :notes, => "Notes,",
        :is_accepted => "",
        :is_rejected => "",
        :reject_notes, => "Reject Notes,",
        :accept_notes => "Accept Notes"
      ),
      DeliveryItem.create!(
        :delivery => "",
        :order_item => "",
        :quantity => "",
        :unit, => "Unit,",
        :accepted_by => "",
        :accepted_date => "",
        :checked_by => "",
        :checked_date, => "Checked Date,",
        :notes, => "Notes,",
        :is_accepted => "",
        :is_rejected => "",
        :reject_notes, => "Reject Notes,",
        :accept_notes => "Accept Notes"
      )
    ])
  end

  it "renders a list of delivery_items" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Unit,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Checked Date,".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Reject Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Accept Notes".to_s, :count => 2
  end
end
