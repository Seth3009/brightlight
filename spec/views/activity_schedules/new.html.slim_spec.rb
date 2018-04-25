require 'rails_helper'

RSpec.describe "activity_schedules/new", type: :view do
  before(:each) do
    assign(:activity_schedule, ActivitySchedule.new(
      :activity => "MyString",
      :is_active => false
    ))
  end

  it "renders new activity_schedule form" do
    render

    assert_select "form[action=?][method=?]", activity_schedules_path, "post" do

      assert_select "input#activity_schedule_activity[name=?]", "activity_schedule[activity]"

      assert_select "input#activity_schedule_is_active[name=?]", "activity_schedule[is_active]"
    end
  end
end
