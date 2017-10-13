require 'rails_helper'

RSpec.describe "stock_items/new", type: :view do
  before(:each) do
    assign(:stock_item, StockItem.new(
      :name, => "MyString",
      :code, => "MyString",
      :description, => "MyString",
      :tags, => "MyString",
      :short_desc, => "MyString",
      :is_active => "",
      :unit_price => "",
      :image => "",
      :stock_category => "",
      :class, => "MyString",
      :group, => "MyString",
      :weight, => "MyString",
      :extra1, => "MyString",
      :extra2 => "MyString"
    ))
  end

  it "renders new stock_item form" do
    render

    assert_select "form[action=?][method=?]", stock_items_path, "post" do

      assert_select "input#stock_item_name,[name=?]", "stock_item[name,]"

      assert_select "input#stock_item_code,[name=?]", "stock_item[code,]"

      assert_select "input#stock_item_description,[name=?]", "stock_item[description,]"

      assert_select "input#stock_item_tags,[name=?]", "stock_item[tags,]"

      assert_select "input#stock_item_short_desc,[name=?]", "stock_item[short_desc,]"

      assert_select "input#stock_item_is_active[name=?]", "stock_item[is_active]"

      assert_select "input#stock_item_unit_price[name=?]", "stock_item[unit_price]"

      assert_select "input#stock_item_image[name=?]", "stock_item[image]"

      assert_select "input#stock_item_stock_category[name=?]", "stock_item[stock_category]"

      assert_select "input#stock_item_class,[name=?]", "stock_item[class,]"

      assert_select "input#stock_item_group,[name=?]", "stock_item[group,]"

      assert_select "input#stock_item_weight,[name=?]", "stock_item[weight,]"

      assert_select "input#stock_item_extra1,[name=?]", "stock_item[extra1,]"

      assert_select "input#stock_item_extra2[name=?]", "stock_item[extra2]"
    end
  end
end
