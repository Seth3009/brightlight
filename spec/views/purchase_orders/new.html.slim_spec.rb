require 'rails_helper'

RSpec.describe "purchase_orders/new", type: :view do
  before(:each) do
    assign(:purchase_order, PurchaseOrder.new(
      :order_num, => "MyString",
      :requestor => "",
      :order_date => "",
      :due_date => "",
      :total_amount => "",
      :is_active => "",
      :currency, => "MyString",
      :deleted => "",
      :notes, => "MyString",
      :completed_date => "",
      :supplier => "",
      :contact, => "MyString",
      :phone_contact, => "MyString",
      :user => "",
      :status => "MyString"
    ))
  end

  it "renders new purchase_order form" do
    render

    assert_select "form[action=?][method=?]", purchase_orders_path, "post" do

      assert_select "input#purchase_order_order_num,[name=?]", "purchase_order[order_num,]"

      assert_select "input#purchase_order_requestor[name=?]", "purchase_order[requestor]"

      assert_select "input#purchase_order_order_date[name=?]", "purchase_order[order_date]"

      assert_select "input#purchase_order_due_date[name=?]", "purchase_order[due_date]"

      assert_select "input#purchase_order_total_amount[name=?]", "purchase_order[total_amount]"

      assert_select "input#purchase_order_is_active[name=?]", "purchase_order[is_active]"

      assert_select "input#purchase_order_currency,[name=?]", "purchase_order[currency,]"

      assert_select "input#purchase_order_deleted[name=?]", "purchase_order[deleted]"

      assert_select "input#purchase_order_notes,[name=?]", "purchase_order[notes,]"

      assert_select "input#purchase_order_completed_date[name=?]", "purchase_order[completed_date]"

      assert_select "input#purchase_order_supplier[name=?]", "purchase_order[supplier]"

      assert_select "input#purchase_order_contact,[name=?]", "purchase_order[contact,]"

      assert_select "input#purchase_order_phone_contact,[name=?]", "purchase_order[phone_contact,]"

      assert_select "input#purchase_order_user[name=?]", "purchase_order[user]"

      assert_select "input#purchase_order_status[name=?]", "purchase_order[status]"
    end
  end
end
