require 'rails_helper'

RSpec.describe "class_budgets/index", type: :view do
  before(:each) do
    assign(:class_budgets, [
      ClassBudget.create!(
        :department => nil,
        :grade_level => nil,
        :grade_section => nil,
        :holder => nil,
        :academic_year => "",
        :month => 2,
        :amount => "9.99",
        :balance => "9.99",
        :actual => "9.99",
        :notes => "Notes"
      ),
      ClassBudget.create!(
        :department => nil,
        :grade_level => nil,
        :grade_section => nil,
        :holder => nil,
        :academic_year => "",
        :month => 2,
        :amount => "9.99",
        :balance => "9.99",
        :actual => "9.99",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of class_budgets" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
