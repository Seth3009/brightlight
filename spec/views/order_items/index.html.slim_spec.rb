require 'rails_helper'

RSpec.describe "order_items/index", type: :view do
  before(:each) do
    assign(:order_items, [
      OrderItem.create!(
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
      ),
      OrderItem.create!(
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
      ),
      OrderItem.create!(
        :purchase_order => nil,
        :no => 2,
        :supplier => "Supplier",
        :supplier_id => 3,
        :req_line => nil,
        :invoice_amt => "9.99",
        :dp_amount => "9.99",
        :notes => "Notes"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
      )
    ])
  end

  it "renders a list of order_items" do
    render
<<<<<<< HEAD
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Unit,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Currency,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "Status,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Extra1,".to_s, :count => 2
    assert_select "tr>td", :text => "Extra2".to_s, :count => 2
=======
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Supplier".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
