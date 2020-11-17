require 'rails_helper'

RSpec.describe "fund_requests/edit", type: :view do
  before(:each) do
    @fund_request = assign(:fund_request, FundRequest.create!(
      :requester_id => 1,
      :description => "MyString",
      :amount => "",
      :payment_type => "MyString",
      :is_budgeted => false,
      :budget_notes => "MyString",
      :is_spv_approved => false,
      :spv_approval_notes => "MyString",
      :is_hos_approved => false,
      :hos_approval_notes => "MyString",
      :receiver_id => 1
    ))
  end

  it "renders the edit fund_request form" do
    render

    assert_select "form[action=?][method=?]", fund_request_path(@fund_request), "post" do

      assert_select "input#fund_request_requester_id[name=?]", "fund_request[requester_id]"

      assert_select "input#fund_request_description[name=?]", "fund_request[description]"

      assert_select "input#fund_request_amount[name=?]", "fund_request[amount]"

      assert_select "input#fund_request_payment_type[name=?]", "fund_request[payment_type]"

      assert_select "input#fund_request_is_budgeted[name=?]", "fund_request[is_budgeted]"

      assert_select "input#fund_request_budget_notes[name=?]", "fund_request[budget_notes]"

      assert_select "input#fund_request_is_spv_approved[name=?]", "fund_request[is_spv_approved]"

      assert_select "input#fund_request_spv_approval_notes[name=?]", "fund_request[spv_approval_notes]"

      assert_select "input#fund_request_is_hos_approved[name=?]", "fund_request[is_hos_approved]"

      assert_select "input#fund_request_hos_approval_notes[name=?]", "fund_request[hos_approval_notes]"

      assert_select "input#fund_request_receiver_id[name=?]", "fund_request[receiver_id]"
    end
  end
end
