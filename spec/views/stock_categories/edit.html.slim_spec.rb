require 'rails_helper'

RSpec.describe "stock_categories/edit", type: :view do
  before(:each) do
    @stock_category = assign(:stock_category, StockCategory.create!(
      :name, => "MyString",
      :code, => "MyString",
      :description, => "MyString",
      :type, => "MyString",
      :is_active => "",
      :location => "MyString"
    ))
  end

  it "renders the edit stock_category form" do
    render

    assert_select "form[action=?][method=?]", stock_category_path(@stock_category), "post" do

      assert_select "input#stock_category_name,[name=?]", "stock_category[name,]"

      assert_select "input#stock_category_code,[name=?]", "stock_category[code,]"

      assert_select "input#stock_category_description,[name=?]", "stock_category[description,]"

      assert_select "input#stock_category_type,[name=?]", "stock_category[type,]"

      assert_select "input#stock_category_is_active[name=?]", "stock_category[is_active]"

      assert_select "input#stock_category_location[name=?]", "stock_category[location]"
    end
  end
end
