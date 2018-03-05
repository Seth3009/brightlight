require 'rails_helper'

RSpec.describe "order_items/show", type: :view do
  before(:each) do
    @order_item = assign(:order_item, OrderItem.create!(
      :purchase_order => "",
      :stock_item => "",
      :quantity => "",
      :unit, => "Unit,",
      :min_delivery_qty => "",
      :pending_qty => "",
      :type, => "Type,",
      :line_amount => "",
      :unit_price => "",
      :currency, => "Currency,",
      :deleted => "",
      :description, => "Description,",
      :status, => "Status,",
      :line_num => "",
      :extra1, => "Extra1,",
      :extra2 => "Extra2"
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
    expect(rendered).to match(/Type,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Currency,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Description,/)
    expect(rendered).to match(/Status,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Extra1,/)
    expect(rendered).to match(/Extra2/)
  end
end
