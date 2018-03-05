require 'rails_helper'

RSpec.describe "deliveries/show", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.create!(
      :purchase_order => "",
      :delivery_date => "",
      :address, => "Address,",
      :accepted_by => "",
      :accepted_date => "",
      :checked_by => "",
      :checked_date => "",
      :notes, => "Notes,",
      :method, => "Method,",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Address,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(/Method,/)
    expect(rendered).to match(/Status/)
  end
end
