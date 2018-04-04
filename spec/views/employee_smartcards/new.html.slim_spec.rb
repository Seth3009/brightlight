require 'rails_helper'

RSpec.describe "employee_smartcards/new", type: :view do
  before(:each) do
    assign(:employee_smartcard, EmployeeSmartcard.new(
      :card => "MyString",
      :employee => nil
    ))
  end

  it "renders new employee_smartcard form" do
    render

    assert_select "form[action=?][method=?]", employee_smartcards_path, "post" do

      assert_select "input#employee_smartcard_card[name=?]", "employee_smartcard[card]"

      assert_select "input#employee_smartcard_employee_id[name=?]", "employee_smartcard[employee_id]"
    end
  end
end
