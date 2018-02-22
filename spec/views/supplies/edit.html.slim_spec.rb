require 'rails_helper'

RSpec.describe "supplies/edit", type: :view do
  before(:each) do
    @supply = assign(:supply, Supply.create!(
      :code => "MyString",
      :name => "MyString",
      :price => "9.99",
      :min_stock => 1.5,
      :max_stock => 1.5,
      :stock_type => "MyString",
      :item_unit => nil,
      :item_category => nil,
      :supply_status => false
    ))
  end

  it "renders the edit supply form" do
    render

    assert_select "form[action=?][method=?]", supply_path(@supply), "post" do

      assert_select "input#supply_code[name=?]", "supply[code]"

      assert_select "input#supply_name[name=?]", "supply[name]"

      assert_select "input#supply_price[name=?]", "supply[price]"

      assert_select "input#supply_min_stock[name=?]", "supply[min_stock]"

      assert_select "input#supply_max_stock[name=?]", "supply[max_stock]"

      assert_select "input#supply_stock_type[name=?]", "supply[stock_type]"

      assert_select "input#supply_item_unit_id[name=?]", "supply[item_unit_id]"

      assert_select "input#supply_item_category_id[name=?]", "supply[item_category_id]"

      assert_select "input#supply_supply_status[name=?]", "supply[supply_status]"
    end
  end
end
