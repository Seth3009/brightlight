require 'rails_helper'

RSpec.describe "purchase_orders/show", type: :view do
  before(:each) do
    @purchase_order = assign(:purchase_order, PurchaseOrder.create!(
      :order_num, => "Order Num,",
      :requestor => "",
      :order_date => "",
      :due_date => "",
      :total_amount => "",
      :is_active => "",
      :currency, => "Currency,",
      :deleted => "",
      :notes, => "Notes,",
      :completed_date => "",
      :supplier => "",
      :contact, => "Contact,",
      :phone_contact, => "Phone Contact,",
      :user => "",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Order Num,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Currency,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Contact,/)
    expect(rendered).to match(/Phone Contact,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
  end
end
