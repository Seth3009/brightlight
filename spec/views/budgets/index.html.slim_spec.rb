require 'rails_helper'

RSpec.describe "budgets/index", type: :view do
  before(:each) do
    assign(:budgets, [
      Budget.create!(
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
        :notes, => "Notes,",
        :category, => "Category,",
        :type, => "Type,",
        :group, => "Group,",
        :version, => "Version,"
      ),
      Budget.create!(
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
        :notes, => "Notes,",
        :category, => "Category,",
        :type, => "Type,",
        :group, => "Group,",
        :version, => "Version,"
      )
    ])
  end

  it "renders a list of budgets" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Category,".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "Group,".to_s, :count => 2
    assert_select "tr>td", :text => "Version,".to_s, :count => 2
  end
end
