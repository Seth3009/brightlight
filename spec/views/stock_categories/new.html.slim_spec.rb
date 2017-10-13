require 'rails_helper'

RSpec.describe "stock_categories/new", type: :view do
  before(:each) do
    assign(:stock_category, StockCategory.new(
      :name, => "MyString",
      :code, => "MyString",
      :description, => "MyString",
      :type, => "MyString",
      :is_active => "",
      :location => "MyString"
    ))
  end

  it "renders new stock_category form" do
    render

    assert_select "form[action=?][method=?]", stock_categories_path, "post" do

      assert_select "input#stock_category_name,[name=?]", "stock_category[name,]"

      assert_select "input#stock_category_code,[name=?]", "stock_category[code,]"

      assert_select "input#stock_category_description,[name=?]", "stock_category[description,]"

      assert_select "input#stock_category_type,[name=?]", "stock_category[type,]"

      assert_select "input#stock_category_is_active[name=?]", "stock_category[is_active]"

      assert_select "input#stock_category_location[name=?]", "stock_category[location]"
    end
  end
end
