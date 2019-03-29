require 'rails_helper'

RSpec.describe "class_budgets/show", type: :view do
  before(:each) do
    @class_budget = assign(:class_budget, ClassBudget.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Notes/)
  end
end
