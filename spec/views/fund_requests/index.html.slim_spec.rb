require 'rails_helper'

RSpec.describe "fund_requests/index", type: :view do
  before(:each) do
    assign(:fund_requests, [
      FundRequest.create!(
        :requester_id => 2,
        :description => "Description",
        :amount => "",
        :payment_type => "Payment Type",
        :is_budgeted => false,
        :budget_notes => "Budget Notes",
        :is_spv_approved => false,
        :spv_approval_notes => "Spv Approval Notes",
        :is_hos_approved => false,
        :hos_approval_notes => "Hos Approval Notes",
        :receiver_id => 3
      ),
      FundRequest.create!(
        :requester_id => 2,
        :description => "Description",
        :amount => "",
        :payment_type => "Payment Type",
        :is_budgeted => false,
        :budget_notes => "Budget Notes",
        :is_spv_approved => false,
        :spv_approval_notes => "Spv Approval Notes",
        :is_hos_approved => false,
        :hos_approval_notes => "Hos Approval Notes",
        :receiver_id => 3
      )
    ])
  end

  it "renders a list of fund_requests" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Budget Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Spv Approval Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Hos Approval Notes".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
