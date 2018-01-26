require 'rails_helper'

RSpec.describe "requisitions/new", type: :view do
  before(:each) do
    assign(:requisition, Requisition.new(
      :req_no, => "MyString",
      :description, => "MyString",
      :is_budgeted => "",
      :budget => "",
      :budget_line => "",
      :date_required => "",
      :date_requested => "",
      :department => "",
      :requester => "",
      :supervisor => "",
      :supv_approval => "",
      :notes, => "MyString",
      :appvl_notes, => "MyString",
      :total_amt, => "MyString",
      :is_budget_approved => "",
      :is_submitted => "",
      :is_approved => "",
      :is_sent_to_supv => "",
      :is_sent_to_purchasing => "",
      :is_sent_for_bgt_approval => "",
      :is_rejected => "",
      :reject_reason, => "MyString",
      :active => false
    ))
  end

  it "renders new requisition form" do
    render

    assert_select "form[action=?][method=?]", requisitions_path, "post" do

      assert_select "input#requisition_req_no,[name=?]", "requisition[req_no,]"

      assert_select "input#requisition_description,[name=?]", "requisition[description,]"

      assert_select "input#requisition_is_budgeted[name=?]", "requisition[is_budgeted]"

      assert_select "input#requisition_budget[name=?]", "requisition[budget]"

      assert_select "input#requisition_budget_line[name=?]", "requisition[budget_line]"

      assert_select "input#requisition_date_required[name=?]", "requisition[date_required]"

      assert_select "input#requisition_date_requested[name=?]", "requisition[date_requested]"

      assert_select "input#requisition_department[name=?]", "requisition[department]"

      assert_select "input#requisition_requester[name=?]", "requisition[requester]"

      assert_select "input#requisition_supervisor[name=?]", "requisition[supervisor]"

      assert_select "input#requisition_supv_approval[name=?]", "requisition[supv_approval]"

      assert_select "input#requisition_notes,[name=?]", "requisition[notes,]"

      assert_select "input#requisition_appvl_notes,[name=?]", "requisition[appvl_notes,]"

      assert_select "input#requisition_total_amt,[name=?]", "requisition[total_amt,]"

      assert_select "input#requisition_is_budget_approved[name=?]", "requisition[is_budget_approved]"

      assert_select "input#requisition_is_submitted[name=?]", "requisition[is_submitted]"

      assert_select "input#requisition_is_approved[name=?]", "requisition[is_approved]"

      assert_select "input#requisition_is_sent_to_supv[name=?]", "requisition[is_sent_to_supv]"

      assert_select "input#requisition_is_sent_to_purchasing[name=?]", "requisition[is_sent_to_purchasing]"

      assert_select "input#requisition_is_sent_for_bgt_approval[name=?]", "requisition[is_sent_for_bgt_approval]"

      assert_select "input#requisition_is_rejected[name=?]", "requisition[is_rejected]"

      assert_select "input#requisition_reject_reason,[name=?]", "requisition[reject_reason,]"

      assert_select "input#requisition_active[name=?]", "requisition[active]"
    end
  end
end
