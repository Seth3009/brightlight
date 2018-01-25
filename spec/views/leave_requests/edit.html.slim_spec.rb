require 'rails_helper'

RSpec.describe "leave_requests/edit", type: :view do
  before(:each) do
    @leave_request = assign(:leave_request, LeaveRequest.create!(
      :hour => "MyString",
      :leave_type => "MyString",
      :leave_note => "MyString",
      :leave_subtitute => false,
      :subtitute_notes => "MyText",
      :spv_approval => false,
      :spv_notes => "MyText",
      :hr_approval => false,
      :hr_notes => "MyText",
      :leave_attachment => "MyString",
      :employee => nil
    ))
  end

  it "renders the edit leave_request form" do
    render

    assert_select "form[action=?][method=?]", leave_request_path(@leave_request), "post" do

      assert_select "input#leave_request_hour[name=?]", "leave_request[hour]"

      assert_select "input#leave_request_leave_type[name=?]", "leave_request[leave_type]"

      assert_select "input#leave_request_leave_note[name=?]", "leave_request[leave_note]"

      assert_select "input#leave_request_leave_subtitute[name=?]", "leave_request[leave_subtitute]"

      assert_select "textarea#leave_request_subtitute_notes[name=?]", "leave_request[subtitute_notes]"

      assert_select "input#leave_request_spv_approval[name=?]", "leave_request[spv_approval]"

      assert_select "textarea#leave_request_spv_notes[name=?]", "leave_request[spv_notes]"

      assert_select "input#leave_request_hr_approval[name=?]", "leave_request[hr_approval]"

      assert_select "textarea#leave_request_hr_notes[name=?]", "leave_request[hr_notes]"

      assert_select "input#leave_request_leave_attachment[name=?]", "leave_request[leave_attachment]"

      assert_select "input#leave_request_employee_id[name=?]", "leave_request[employee_id]"
    end
  end
end
