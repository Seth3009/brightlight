require 'rails_helper'

RSpec.describe "requisitions/show", type: :view do
  before(:each) do
    @requisition = assign(:requisition, Requisition.create!(
<<<<<<< HEAD
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
=======
      :req_no => "Req No",
      :department => nil,
      :requester => nil,
      :supv_approved => false,
      :supv_notes => "Supv Notes",
      :notes => "Notes",
      :budgetted => false,
      :budget_approved => false,
      :bdgt_appvd_by => nil,
      :bdgt_appvd_name => "Bdgt Appvd Name",
      :bdgt_appv_notes => "Bdgt Appv Notes",
      :sent_purch => false,
      :sent_supv => false,
      :sent_bdgt_appv => false,
      :notes => "Notes",
      :origin => "Origin"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders attributes in <p>" do
    render
<<<<<<< HEAD
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
=======
    expect(rendered).to match(/Req No/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Supv Notes/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Bdgt Appvd Name/)
    expect(rendered).to match(/Bdgt Appv Notes/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/Origin/)
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
  end
end
