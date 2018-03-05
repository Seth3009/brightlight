require 'rails_helper'

RSpec.describe "budgets/show", type: :view do
  before(:each) do
    @budget = assign(:budget, Budget.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(/Category,/)
    expect(rendered).to match(/Type,/)
    expect(rendered).to match(/Group,/)
    expect(rendered).to match(/Version,/)
  end
end
