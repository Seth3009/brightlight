require 'rails_helper'

RSpec.describe "budget_items/index", type: :view do
  before(:each) do
    assign(:budget_items, [
      BudgetItem.create!(
<<<<<<< HEAD
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
=======
        :budget => nil,
        :description => "Description",
        :notes => "Notes",
        :amount => "9.99",
        :currency => "Currency",
        :used_amount => "9.99",
        :completed => false,
        :appvl_notes => "Appvl Notes",
        :approved => false,
        :approver => nil
      ),
      BudgetItem.create!(
        :budget => nil,
        :description => "Description",
        :notes => "Notes",
        :amount => "9.99",
        :currency => "Currency",
        :used_amount => "9.99",
        :completed => false,
        :appvl_notes => "Appvl Notes",
        :approved => false,
        :approver => nil
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
      )
    ])
  end

  it "renders a list of budget_items" do
    render
<<<<<<< HEAD
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
=======
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Appvl Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
