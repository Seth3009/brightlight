require 'rails_helper'

RSpec.describe "req_items/edit", type: :view do
  before(:each) do
    @req_item = assign(:req_item, ReqItem.create!(
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

  it "renders the edit req_item form" do
    render

    assert_select "form[action=?][method=?]", req_item_path(@req_item), "post" do

      assert_select "input#req_item_requisition[name=?]", "req_item[requisition]"

      assert_select "input#req_item_description,[name=?]", "req_item[description,]"

      assert_select "input#req_item_qty_reqd[name=?]", "req_item[qty_reqd]"

      assert_select "input#req_item_unit,[name=?]", "req_item[unit,]"

      assert_select "input#req_item_est_price[name=?]", "req_item[est_price]"

      assert_select "input#req_item_actual_price[name=?]", "req_item[actual_price]"

      assert_select "input#req_item_currency,[name=?]", "req_item[currency,]"

      assert_select "input#req_item_notes,[name=?]", "req_item[notes,]"

      assert_select "input#req_item_qty_ordered[name=?]", "req_item[qty_ordered]"

      assert_select "input#req_item_order_date[name=?]", "req_item[order_date]"

      assert_select "input#req_item_qty_delivered[name=?]", "req_item[qty_delivered]"

      assert_select "input#req_item_delivery_date[name=?]", "req_item[delivery_date]"

      assert_select "input#req_item_qty_accepted[name=?]", "req_item[qty_accepted]"

      assert_select "input#req_item_acceptance_date[name=?]", "req_item[acceptance_date]"

      assert_select "input#req_item_qty_rejected[name=?]", "req_item[qty_rejected]"

      assert_select "input#req_item_needed_by_date[name=?]", "req_item[needed_by_date]"

      assert_select "input#req_item_acceptance_notes,[name=?]", "req_item[acceptance_notes,]"

      assert_select "input#req_item_reject_notes[name=?]", "req_item[reject_notes]"
    end
  end
end
