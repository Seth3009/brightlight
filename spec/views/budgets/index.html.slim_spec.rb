require 'rails_helper'

RSpec.describe "budgets/index", type: :view do
  before(:each) do
    assign(:budgets, [
      Budget.create!(
<<<<<<< HEAD
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
=======
        :department => nil,
        :owner => nil,
        :grade_level => nil,
        :grade_section => nil,
        :academic_year => nil,
        :submitted => false,
        :approved => false,
        :approver => nil,
        :type => "Type",
        :category => "Category",
        :active => false,
        :notes => "Notes"
      ),
      Budget.create!(
        :department => nil,
        :owner => nil,
        :grade_level => nil,
        :grade_section => nil,
        :academic_year => nil,
        :submitted => false,
        :approved => false,
        :approver => nil,
        :type => "Type",
        :category => "Category",
        :active => false,
        :notes => "Notes"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
      )
    ])
  end

  it "renders a list of budgets" do
    render
<<<<<<< HEAD
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
=======
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
