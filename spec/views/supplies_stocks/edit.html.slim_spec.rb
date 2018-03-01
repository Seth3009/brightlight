require 'rails_helper'

RSpec.describe "supplies_stocks/edit", type: :view do
  before(:each) do
    @supplies_stock = assign(:supplies_stock, SuppliesStock.create!(
      :trx_type => "MyString",
      :qty => 1.5,
      :trx_notes => "MyString",
      :supply => nil,
      :user => nil,
      :warehouse => nil
    ))
  end

  it "renders the edit supplies_stock form" do
    render

    assert_select "form[action=?][method=?]", supplies_stock_path(@supplies_stock), "post" do

      assert_select "input#supplies_stock_trx_type[name=?]", "supplies_stock[trx_type]"

      assert_select "input#supplies_stock_qty[name=?]", "supplies_stock[qty]"

      assert_select "input#supplies_stock_trx_notes[name=?]", "supplies_stock[trx_notes]"

      assert_select "input#supplies_stock_supply_id[name=?]", "supplies_stock[supply_id]"

      assert_select "input#supplies_stock_user_id[name=?]", "supplies_stock[user_id]"

      assert_select "input#supplies_stock_warehouse_id[name=?]", "supplies_stock[warehouse_id]"
    end
  end
end
