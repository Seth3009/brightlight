require 'rails_helper'

RSpec.describe "supplies_stocks/new", type: :view do
  before(:each) do
    assign(:supplies_stock, SuppliesStock.new(
      :trx_type => "MyString",
      :qty => 1.5,
      :trx_notes => "MyString",
      :supply => nil,
      :user => nil,
      :warehouse => nil
    ))
  end

  it "renders new supplies_stock form" do
    render

    assert_select "form[action=?][method=?]", supplies_stocks_path, "post" do

      assert_select "input#supplies_stock_trx_type[name=?]", "supplies_stock[trx_type]"

      assert_select "input#supplies_stock_qty[name=?]", "supplies_stock[qty]"

      assert_select "input#supplies_stock_trx_notes[name=?]", "supplies_stock[trx_notes]"

      assert_select "input#supplies_stock_supply_id[name=?]", "supplies_stock[supply_id]"

      assert_select "input#supplies_stock_user_id[name=?]", "supplies_stock[user_id]"

      assert_select "input#supplies_stock_warehouse_id[name=?]", "supplies_stock[warehouse_id]"
    end
  end
end
