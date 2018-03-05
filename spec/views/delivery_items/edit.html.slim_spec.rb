require 'rails_helper'

RSpec.describe "delivery_items/edit", type: :view do
  before(:each) do
    @delivery_item = assign(:delivery_item, DeliveryItem.create!(
      :delivery => "",
      :order_item => "",
      :quantity => "",
      :unit, => "MyString",
      :accepted_by => "",
      :accepted_date => "",
      :checked_by => "",
      :checked_date, => "MyString",
      :notes, => "MyString",
      :is_accepted => "",
      :is_rejected => "",
      :reject_notes, => "MyString",
      :accept_notes => "MyString"
    ))
  end

  it "renders the edit delivery_item form" do
    render

    assert_select "form[action=?][method=?]", delivery_item_path(@delivery_item), "post" do

      assert_select "input#delivery_item_delivery[name=?]", "delivery_item[delivery]"

      assert_select "input#delivery_item_order_item[name=?]", "delivery_item[order_item]"

      assert_select "input#delivery_item_quantity[name=?]", "delivery_item[quantity]"

      assert_select "input#delivery_item_unit,[name=?]", "delivery_item[unit,]"

      assert_select "input#delivery_item_accepted_by[name=?]", "delivery_item[accepted_by]"

      assert_select "input#delivery_item_accepted_date[name=?]", "delivery_item[accepted_date]"

      assert_select "input#delivery_item_checked_by[name=?]", "delivery_item[checked_by]"

      assert_select "input#delivery_item_checked_date,[name=?]", "delivery_item[checked_date,]"

      assert_select "input#delivery_item_notes,[name=?]", "delivery_item[notes,]"

      assert_select "input#delivery_item_is_accepted[name=?]", "delivery_item[is_accepted]"

      assert_select "input#delivery_item_is_rejected[name=?]", "delivery_item[is_rejected]"

      assert_select "input#delivery_item_reject_notes,[name=?]", "delivery_item[reject_notes,]"

      assert_select "input#delivery_item_accept_notes[name=?]", "delivery_item[accept_notes]"
    end
  end
end
