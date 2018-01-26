require 'rails_helper'

RSpec.describe "requisitions/index", type: :view do
  before(:each) do
    assign(:requisitions, [
      Requisition.create!(
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
      ),
      Requisition.create!(
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
      )
    ])
  end

  it "renders a list of requisitions" do
    render
    assert_select "tr>td", :text => "Req No,".to_s, :count => 2
    assert_select "tr>td", :text => "Description,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Appvl Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Total Amt,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Reject Reason,".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
