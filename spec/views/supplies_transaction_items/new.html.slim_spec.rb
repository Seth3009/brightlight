require 'rails_helper'

RSpec.describe "supplies_transaction_items/new", type: :view do
  before(:each) do
    assign(:supplies_transaction_item, SuppliesTransactionItem.new(
      :supplies_transaction => nil,
      :product => nil,
      :in_out => "MyString",
      :qty => 1.5
    ))
  end

  it "renders new supplies_transaction_item form" do
    render

    assert_select "form[action=?][method=?]", supplies_transaction_items_path, "post" do

      assert_select "input#supplies_transaction_item_supplies_transaction_id[name=?]", "supplies_transaction_item[supplies_transaction_id]"

      assert_select "input#supplies_transaction_item_product_id[name=?]", "supplies_transaction_item[product_id]"

      assert_select "input#supplies_transaction_item_in_out[name=?]", "supplies_transaction_item[in_out]"

      assert_select "input#supplies_transaction_item_qty[name=?]", "supplies_transaction_item[qty]"
    end
  end
end
