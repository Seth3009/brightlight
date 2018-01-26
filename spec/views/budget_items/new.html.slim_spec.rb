require 'rails_helper'

RSpec.describe "budget_items/new", type: :view do
  before(:each) do
    assign(:budget_item, BudgetItem.new(
      :budget => "",
      :description, => "MyString",
      :account, => "MyString",
      :line => "",
      :notes, => "MyString",
      :academic_year => "",
      :month => "",
      :amount => "",
      :actual_amt => "",
      :is_completed => "",
      :type, => "MyString",
      :category, => "MyString",
      :group => "MyString"
    ))
  end

  it "renders new budget_item form" do
    render

    assert_select "form[action=?][method=?]", budget_items_path, "post" do

      assert_select "input#budget_item_budget[name=?]", "budget_item[budget]"

      assert_select "input#budget_item_description,[name=?]", "budget_item[description,]"

      assert_select "input#budget_item_account,[name=?]", "budget_item[account,]"

      assert_select "input#budget_item_line[name=?]", "budget_item[line]"

      assert_select "input#budget_item_notes,[name=?]", "budget_item[notes,]"

      assert_select "input#budget_item_academic_year[name=?]", "budget_item[academic_year]"

      assert_select "input#budget_item_month[name=?]", "budget_item[month]"

      assert_select "input#budget_item_amount[name=?]", "budget_item[amount]"

      assert_select "input#budget_item_actual_amt[name=?]", "budget_item[actual_amt]"

      assert_select "input#budget_item_is_completed[name=?]", "budget_item[is_completed]"

      assert_select "input#budget_item_type,[name=?]", "budget_item[type,]"

      assert_select "input#budget_item_category,[name=?]", "budget_item[category,]"

      assert_select "input#budget_item_group[name=?]", "budget_item[group]"
    end
  end
end
