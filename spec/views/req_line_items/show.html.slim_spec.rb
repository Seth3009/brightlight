require 'rails_helper'

RSpec.describe "req_line_items/show", type: :view do
  before(:each) do
    @req_line_item = assign(:req_line_item, ReqLineItem.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Description,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Unit,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Currency,/)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Acceptance Notes,/)
    expect(rendered).to match(/Reject Notes/)
  end
end
