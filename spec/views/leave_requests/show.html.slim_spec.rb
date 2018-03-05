require 'rails_helper'

RSpec.describe "leave_requests/show", type: :view do
  before(:each) do
    @leave_request = assign(:leave_request, LeaveRequest.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hour/)
    expect(rendered).to match(/Leave Type/)
    expect(rendered).to match(/Leave Note/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Leave Attachment/)
    expect(rendered).to match(//)
  end
end
