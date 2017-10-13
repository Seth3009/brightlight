require 'rails_helper'

RSpec.describe "requisitions/new", type: :view do
  before(:each) do
    assign(:requisition, Requisition.new(
<<<<<<< HEAD
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
=======
      :req_no => "MyString",
      :department => nil,
      :requester => nil,
      :supv_approved => false,
      :supv_notes => "MyString",
      :notes => "MyString",
      :budgetted => false,
      :budget_approved => false,
      :bdgt_appvd_by => nil,
      :bdgt_appvd_name => "MyString",
      :bdgt_appv_notes => "MyString",
      :sent_purch => false,
      :sent_supv => false,
      :sent_bdgt_appv => false,
      :notes => "MyString",
      :origin => "MyString"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders new requisition form" do
    render

    assert_select "form[action=?][method=?]", requisitions_path, "post" do

<<<<<<< HEAD
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
=======
      assert_select "input#requisition_req_no[name=?]", "requisition[req_no]"

      assert_select "input#requisition_department_id[name=?]", "requisition[department_id]"

      assert_select "input#requisition_requester_id[name=?]", "requisition[requester_id]"

      assert_select "input#requisition_supv_approved[name=?]", "requisition[supv_approved]"

      assert_select "input#requisition_supv_notes[name=?]", "requisition[supv_notes]"

      assert_select "input#requisition_notes[name=?]", "requisition[notes]"

      assert_select "input#requisition_budgetted[name=?]", "requisition[budgetted]"

      assert_select "input#requisition_budget_approved[name=?]", "requisition[budget_approved]"

      assert_select "input#requisition_bdgt_appvd_by_id[name=?]", "requisition[bdgt_appvd_by_id]"

      assert_select "input#requisition_bdgt_appvd_name[name=?]", "requisition[bdgt_appvd_name]"

      assert_select "input#requisition_bdgt_appv_notes[name=?]", "requisition[bdgt_appv_notes]"

      assert_select "input#requisition_sent_purch[name=?]", "requisition[sent_purch]"

      assert_select "input#requisition_sent_supv[name=?]", "requisition[sent_supv]"

      assert_select "input#requisition_sent_bdgt_appv[name=?]", "requisition[sent_bdgt_appv]"

      assert_select "input#requisition_notes[name=?]", "requisition[notes]"

      assert_select "input#requisition_origin[name=?]", "requisition[origin]"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    end
  end
end
