require 'rails_helper'

RSpec.describe "fund_requests/show", type: :view do
  before(:each) do
    @fund_request = assign(:fund_request, FundRequest.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Payment Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Budget Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Spv Approval Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Hos Approval Notes/)
    expect(rendered).to match(/3/)
  end
end
