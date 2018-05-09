require 'rails_helper'

RSpec.describe "activity_schedules/edit", type: :view do
  before(:each) do
    @activity_schedule = assign(:activity_schedule, ActivitySchedule.create!(
      :activity => "MyString",
      :is_active => false
    ))
  end

  it "renders the edit activity_schedule form" do
    render

    assert_select "form[action=?][method=?]", activity_schedule_path(@activity_schedule), "post" do

      assert_select "input#activity_schedule_activity[name=?]", "activity_schedule[activity]"

      assert_select "input#activity_schedule_is_active[name=?]", "activity_schedule[is_active]"
    end
  end
end
