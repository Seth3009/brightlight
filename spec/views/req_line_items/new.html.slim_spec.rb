require 'rails_helper'

RSpec.describe "req_line_items/new", type: :view do
  before(:each) do
    assign(:req_line_item, ReqLineItem.new(
      :requisition => "",
      :description, => "MyString",
      :qty_reqd => "",
      :unit, => "MyString",
      :est_price => "",
      :actual_price => "",
      :currency, => "MyString",
      :notes, => "MyString",
      :qty_ordered => "",
      :order_date => "",
      :qty_delivered => "",
      :delivery_date => "",
      :qty_accepted => "",
      :acceptance_date => "",
      :qty_rejected => "",
      :needed_by_date => "",
      :acceptance_notes, => "MyString",
      :reject_notes => "MyString"
    ))
  end

  it "renders new req_line_item form" do
    render

    assert_select "form[action=?][method=?]", req_line_items_path, "post" do

      assert_select "input#req_line_item_requisition[name=?]", "req_line_item[requisition]"

      assert_select "input#req_line_item_description,[name=?]", "req_line_item[description,]"

      assert_select "input#req_line_item_qty_reqd[name=?]", "req_line_item[qty_reqd]"

      assert_select "input#req_line_item_unit,[name=?]", "req_line_item[unit,]"

      assert_select "input#req_line_item_est_price[name=?]", "req_line_item[est_price]"

      assert_select "input#req_line_item_actual_price[name=?]", "req_line_item[actual_price]"

      assert_select "input#req_line_item_currency,[name=?]", "req_line_item[currency,]"

      assert_select "input#req_line_item_notes,[name=?]", "req_line_item[notes,]"

      assert_select "input#req_line_item_qty_ordered[name=?]", "req_line_item[qty_ordered]"

      assert_select "input#req_line_item_order_date[name=?]", "req_line_item[order_date]"

      assert_select "input#req_line_item_qty_delivered[name=?]", "req_line_item[qty_delivered]"

      assert_select "input#req_line_item_delivery_date[name=?]", "req_line_item[delivery_date]"

      assert_select "input#req_line_item_qty_accepted[name=?]", "req_line_item[qty_accepted]"

      assert_select "input#req_line_item_acceptance_date[name=?]", "req_line_item[acceptance_date]"

      assert_select "input#req_line_item_qty_rejected[name=?]", "req_line_item[qty_rejected]"

      assert_select "input#req_line_item_needed_by_date[name=?]", "req_line_item[needed_by_date]"

      assert_select "input#req_line_item_acceptance_notes,[name=?]", "req_line_item[acceptance_notes,]"

      assert_select "input#req_line_item_reject_notes[name=?]", "req_line_item[reject_notes]"
    end
  end
end
