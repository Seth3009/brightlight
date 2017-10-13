require 'rails_helper'

RSpec.describe "purchase_orders/index", type: :view do
  before(:each) do
    assign(:purchase_orders, [
      PurchaseOrder.create!(
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
      ),
      PurchaseOrder.create!(
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
      )
    ])
  end

  it "renders a list of purchase_orders" do
    render
    assert_select "tr>td", :text => "Order Num,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Currency,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Contact,".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Contact,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
