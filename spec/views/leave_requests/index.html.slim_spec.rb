require 'rails_helper'

RSpec.describe "leave_requests/index", type: :view do
  before(:each) do
    assign(:leave_requests, [
      LeaveRequest.create!(
        :hour => "Hour",
        :leave_type => "Leave Type",
        :leave_note => "Leave Note",
        :leave_subtitute => false,
        :subtitute_notes => "MyText",
        :spv_approval => false,
        :spv_notes => "MyText",
        :hr_approval => false,
        :hr_notes => "MyText",
        :leave_attachment => "Leave Attachment",
        :employee => nil
      ),
      LeaveRequest.create!(
        :hour => "Hour",
        :leave_type => "Leave Type",
        :leave_note => "Leave Note",
        :leave_subtitute => false,
        :subtitute_notes => "MyText",
        :spv_approval => false,
        :spv_notes => "MyText",
        :hr_approval => false,
        :hr_notes => "MyText",
        :leave_attachment => "Leave Attachment",
        :employee => nil
      )
    ])
  end

  it "renders a list of leave_requests" do
    render
    assert_select "tr>td", :text => "Hour".to_s, :count => 2
    assert_select "tr>td", :text => "Leave Type".to_s, :count => 2
    assert_select "tr>td", :text => "Leave Note".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Leave Attachment".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
