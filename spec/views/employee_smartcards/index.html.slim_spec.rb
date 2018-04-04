require 'rails_helper'

RSpec.describe "employee_smartcards/index", type: :view do
  before(:each) do
    assign(:employee_smartcards, [
      EmployeeSmartcard.create!(
        :card => "Card",
        :employee => nil
      ),
      EmployeeSmartcard.create!(
        :card => "Card",
        :employee => nil
      )
    ])
  end

  it "renders a list of employee_smartcards" do
    render
    assert_select "tr>td", :text => "Card".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
