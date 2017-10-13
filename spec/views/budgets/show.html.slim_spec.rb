require 'rails_helper'

RSpec.describe "budgets/show", type: :view do
  before(:each) do
    @budget = assign(:budget, Budget.create!(
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
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
<<<<<<< HEAD
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
=======
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notes/)
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
