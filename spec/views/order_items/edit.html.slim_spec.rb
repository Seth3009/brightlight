require 'rails_helper'

RSpec.describe "order_items/edit", type: :view do
  before(:each) do
    @order_item = assign(:order_item, OrderItem.create!(
<<<<<<< HEAD
      :purchase_order => "",
      :stock_item => "",
      :quantity => "",
      :unit, => "MyString",
      :min_delivery_qty => "",
      :pending_qty => "",
      :type, => "MyString",
      :line_amount => "",
      :unit_price => "",
      :currency, => "MyString",
      :deleted => "",
      :description, => "MyString",
      :status, => "MyString",
      :line_num => "",
      :extra1, => "MyString",
      :extra2 => "MyString"
=======
      :purchase_order => nil,
      :no => 1,
      :supplier => "MyString",
      :supplier_id => 1,
      :req_line => nil,
      :invoice_amt => "9.99",
      :dp_amount => "9.99",
      :notes => "MyString"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders the edit order_item form" do
    render

    assert_select "form[action=?][method=?]", order_item_path(@order_item), "post" do

<<<<<<< HEAD
      assert_select "input#order_item_purchase_order[name=?]", "order_item[purchase_order]"

      assert_select "input#order_item_stock_item[name=?]", "order_item[stock_item]"

      assert_select "input#order_item_quantity[name=?]", "order_item[quantity]"

      assert_select "input#order_item_unit,[name=?]", "order_item[unit,]"

      assert_select "input#order_item_min_delivery_qty[name=?]", "order_item[min_delivery_qty]"

      assert_select "input#order_item_pending_qty[name=?]", "order_item[pending_qty]"

      assert_select "input#order_item_type,[name=?]", "order_item[type,]"

      assert_select "input#order_item_line_amount[name=?]", "order_item[line_amount]"

      assert_select "input#order_item_unit_price[name=?]", "order_item[unit_price]"

      assert_select "input#order_item_currency,[name=?]", "order_item[currency,]"

      assert_select "input#order_item_deleted[name=?]", "order_item[deleted]"

      assert_select "input#order_item_description,[name=?]", "order_item[description,]"

      assert_select "input#order_item_status,[name=?]", "order_item[status,]"

      assert_select "input#order_item_line_num[name=?]", "order_item[line_num]"

      assert_select "input#order_item_extra1,[name=?]", "order_item[extra1,]"

      assert_select "input#order_item_extra2[name=?]", "order_item[extra2]"
=======
      assert_select "input#order_item_purchase_order_id[name=?]", "order_item[purchase_order_id]"

      assert_select "input#order_item_no[name=?]", "order_item[no]"

      assert_select "input#order_item_supplier[name=?]", "order_item[supplier]"

      assert_select "input#order_item_supplier_id[name=?]", "order_item[supplier_id]"

      assert_select "input#order_item_req_line_id[name=?]", "order_item[req_line_id]"

      assert_select "input#order_item_invoice_amt[name=?]", "order_item[invoice_amt]"

      assert_select "input#order_item_dp_amount[name=?]", "order_item[dp_amount]"

      assert_select "input#order_item_notes[name=?]", "order_item[notes]"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    end
  end
end
