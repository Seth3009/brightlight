require 'rails_helper'

RSpec.describe "budget_items/index", type: :view do
  before(:each) do
    assign(:budget_items, [
      BudgetItem.create!(
        :budget => "",
        :description => "Description,",
        :account => "Account,",
        :line => "",
        :notes => "Notes,",
        :academic_year => "",
        :month => "",
        :amount => "",
        :actual_amt => "",
        :is_completed => "",
        :type => "Type,",
        :category => "Category,",
        :group => "Group"
      ),
      BudgetItem.create!(
        :budget => "",
        :description, => "Description,",
        :account, => "Account,",
        :line => "",
        :notes, => "Notes,",
        :academic_year => "",
        :month => "",
        :amount => "",
        :actual_amt => "",
        :is_completed => "",
        :type, => "Type,",
        :category, => "Category,",
        :group => "Group"
      )
    ])
  end

  it "renders a list of budget_items" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "Account,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "Category,".to_s, :count => 2
    assert_select "tr>td", :text => "Group".to_s, :count => 2
  end
end
