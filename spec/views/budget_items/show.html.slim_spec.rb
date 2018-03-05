require 'rails_helper'

RSpec.describe "budget_items/show", type: :view do
  before(:each) do
    @budget_item = assign(:budget_item, BudgetItem.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Description,/)
    expect(rendered).to match(/Account,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Type,/)
    expect(rendered).to match(/Category,/)
    expect(rendered).to match(/Group/)
  end
end
