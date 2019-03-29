require 'rails_helper'

RSpec.describe "class_budgets/new", type: :view do
  before(:each) do
    assign(:class_budget, ClassBudget.new(
      :department => nil,
      :grade_level => nil,
      :grade_section => nil,
      :holder => nil,
      :academic_year => "",
      :month => 1,
      :amount => "9.99",
      :balance => "9.99",
      :actual => "9.99",
      :notes => "MyString"
    ))
  end

  it "renders new class_budget form" do
    render

    assert_select "form[action=?][method=?]", class_budgets_path, "post" do

      assert_select "input#class_budget_department_id[name=?]", "class_budget[department_id]"

      assert_select "input#class_budget_grade_level_id[name=?]", "class_budget[grade_level_id]"

      assert_select "input#class_budget_grade_section_id[name=?]", "class_budget[grade_section_id]"

      assert_select "input#class_budget_holder_id[name=?]", "class_budget[holder_id]"

      assert_select "input#class_budget_academic_year[name=?]", "class_budget[academic_year]"

      assert_select "input#class_budget_month[name=?]", "class_budget[month]"

      assert_select "input#class_budget_amount[name=?]", "class_budget[amount]"

      assert_select "input#class_budget_balance[name=?]", "class_budget[balance]"

      assert_select "input#class_budget_actual[name=?]", "class_budget[actual]"

      assert_select "input#class_budget_notes[name=?]", "class_budget[notes]"
    end
  end
end
