require 'rails_helper'

RSpec.describe "delivery_items/show", type: :view do
  before(:each) do
    @delivery_item = assign(:delivery_item, DeliveryItem.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Unit,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Checked Date,/)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reject Notes,/)
    expect(rendered).to match(/Accept Notes/)
  end
end
