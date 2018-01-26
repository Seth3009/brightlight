require 'rails_helper'

RSpec.describe "requisitions/show", type: :view do
  before(:each) do
    @requisition = assign(:requisition, Requisition.create!(
      :req_no, => "Req No,",
      :description, => "Description,",
      :is_budgeted => "",
      :budget => "",
      :budget_line => "",
      :date_required => "",
      :date_requested => "",
      :department => "",
      :requester => "",
      :supervisor => "",
      :supv_approval => "",
      :notes, => "Notes,",
      :appvl_notes, => "Appvl Notes,",
      :total_amt, => "Total Amt,",
      :is_budget_approved => "",
      :is_submitted => "",
      :is_approved => "",
      :is_sent_to_supv => "",
      :is_sent_to_purchasing => "",
      :is_sent_for_bgt_approval => "",
      :is_rejected => "",
      :reject_reason, => "Reject Reason,",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Req No,/)
    expect(rendered).to match(/Description,/)
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
    expect(rendered).to match(/Appvl Notes,/)
    expect(rendered).to match(/Total Amt,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reject Reason,/)
    expect(rendered).to match(/false/)
  end
end
