require 'rails_helper'

RSpec.describe "budget_items/show", type: :view do
  before(:each) do
    @budget_item = assign(:budget_item, BudgetItem.create!(
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
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
<<<<<<< HEAD
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
=======
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Appvl Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
