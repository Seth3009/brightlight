require 'rails_helper'

RSpec.describe "budgets/new", type: :view do
  before(:each) do
    assign(:budget, Budget.new(
      :department => "",
      :grade_level => "",
      :grade_section => "",
      :budget_holder => "",
      :academic_year => "",
      :is_submitted => "",
      :submit_date => "",
      :is_approved => "",
      :approved_date => "",
      :approver => "",
      :is_received => "",
      :receiver => "",
      :received_date => "",
      :total_amt => "",
      :notes, => "MyString",
      :category, => "MyString",
      :type, => "MyString",
      :group, => "MyString",
      :version, => "MyString"
    ))
  end

  it "renders new budget form" do
    render

    assert_select "form[action=?][method=?]", budgets_path, "post" do

      assert_select "input#budget_department[name=?]", "budget[department]"

      assert_select "input#budget_grade_level[name=?]", "budget[grade_level]"

      assert_select "input#budget_grade_section[name=?]", "budget[grade_section]"

      assert_select "input#budget_budget_holder[name=?]", "budget[budget_holder]"

      assert_select "input#budget_academic_year[name=?]", "budget[academic_year]"

      assert_select "input#budget_is_submitted[name=?]", "budget[is_submitted]"

      assert_select "input#budget_submit_date[name=?]", "budget[submit_date]"

      assert_select "input#budget_is_approved[name=?]", "budget[is_approved]"

      assert_select "input#budget_approved_date[name=?]", "budget[approved_date]"

      assert_select "input#budget_approver[name=?]", "budget[approver]"

      assert_select "input#budget_is_received[name=?]", "budget[is_received]"

      assert_select "input#budget_receiver[name=?]", "budget[receiver]"

      assert_select "input#budget_received_date[name=?]", "budget[received_date]"

      assert_select "input#budget_total_amt[name=?]", "budget[total_amt]"

      assert_select "input#budget_notes,[name=?]", "budget[notes,]"

      assert_select "input#budget_category,[name=?]", "budget[category,]"

      assert_select "input#budget_type,[name=?]", "budget[type,]"

      assert_select "input#budget_group,[name=?]", "budget[group,]"

      assert_select "input#budget_version,[name=?]", "budget[version,]"
    end
  end
end
