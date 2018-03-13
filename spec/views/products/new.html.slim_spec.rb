require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :code => "MyString",
      :name => "MyString",
      :price => "9.99",
      :min_stock => 1.5,
      :max_stock => 1.5,
      :stock_type => "MyString",
      :item_unit => nil,
      :item_category => nil,
      :is_active => false,
      :img_url => "MyString"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_code[name=?]", "product[code]"

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_min_stock[name=?]", "product[min_stock]"

      assert_select "input#product_max_stock[name=?]", "product[max_stock]"

      assert_select "input#product_stock_type[name=?]", "product[stock_type]"

      assert_select "input#product_item_unit_id[name=?]", "product[item_unit_id]"

      assert_select "input#product_item_category_id[name=?]", "product[item_category_id]"

      assert_select "input#product_is_active[name=?]", "product[is_active]"

      assert_select "input#product_img_url[name=?]", "product[img_url]"
    end
  end
end
