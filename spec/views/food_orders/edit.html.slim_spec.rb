require 'rails_helper'

RSpec.describe "food_orders/edit", type: :view do
  before(:each) do
    @food_order = assign(:food_order, FoodOrder.create!(
      :order_notes => "MyString",
      :food_supplier => nil,
      :is_completed => false
    ))
  end

  it "renders the edit food_order form" do
    render

    assert_select "form[action=?][method=?]", food_order_path(@food_order), "post" do

      assert_select "input#food_order_order_notes[name=?]", "food_order[order_notes]"

      assert_select "input#food_order_food_supplier_id[name=?]", "food_order[food_supplier_id]"

      assert_select "input#food_order_is_completed[name=?]", "food_order[is_completed]"
    end
  end
end
