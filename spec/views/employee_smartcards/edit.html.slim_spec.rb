require 'rails_helper'

RSpec.describe "employee_smartcards/edit", type: :view do
  before(:each) do
    @employee_smartcard = assign(:employee_smartcard, EmployeeSmartcard.create!(
      :card => "MyString",
      :employee => nil
    ))
  end

  it "renders the edit employee_smartcard form" do
    render

    assert_select "form[action=?][method=?]", employee_smartcard_path(@employee_smartcard), "post" do

      assert_select "input#employee_smartcard_card[name=?]", "employee_smartcard[card]"

      assert_select "input#employee_smartcard_employee_id[name=?]", "employee_smartcard[employee_id]"
    end
  end
end
