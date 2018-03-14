require 'rails_helper'

RSpec.describe "employee_smartcards/show", type: :view do
  before(:each) do
    @employee_smartcard = assign(:employee_smartcard, EmployeeSmartcard.create!(
      :card => "Card",
      :employee => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Card/)
    expect(rendered).to match(//)
  end
end
