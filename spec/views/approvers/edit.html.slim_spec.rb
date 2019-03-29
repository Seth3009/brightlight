require 'rails_helper'

RSpec.describe "approvers/edit", type: :view do
  before(:each) do
    @approver = assign(:approver, Approver.create!(
      :employee => nil,
      :category => "MyString",
      :department => nil,
      :event => nil,
      :level => 1,
      :type => "",
      :notes => "MyString",
      :active => false
    ))
  end

  it "renders the edit approver form" do
    render

    assert_select "form[action=?][method=?]", approver_path(@approver), "post" do

      assert_select "input#approver_employee_id[name=?]", "approver[employee_id]"

      assert_select "input#approver_category[name=?]", "approver[category]"

      assert_select "input#approver_department_id[name=?]", "approver[department_id]"

      assert_select "input#approver_event_id[name=?]", "approver[event_id]"

      assert_select "input#approver_level[name=?]", "approver[level]"

      assert_select "input#approver_type[name=?]", "approver[type]"

      assert_select "input#approver_notes[name=?]", "approver[notes]"

      assert_select "input#approver_active[name=?]", "approver[active]"
    end
  end
end
