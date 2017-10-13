require 'rails_helper'

RSpec.describe "order_items/show", type: :view do
  before(:each) do
    @order_item = assign(:order_item, OrderItem.create!(
<<<<<<< HEAD
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
=======
      :purchase_order => nil,
      :no => 2,
      :supplier => "Supplier",
      :supplier_id => 3,
      :req_line => nil,
      :invoice_amt => "9.99",
      :dp_amount => "9.99",
      :notes => "Notes"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
<<<<<<< HEAD
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
=======
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Supplier/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Notes/)
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
